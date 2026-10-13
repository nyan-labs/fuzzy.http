package;

import fuzzy.http.Response;
import sys.net.Host;

class Main {	
  static function main() {
    var server = new fuzzy.http.Server(new Host("0.0.0.0"), 3000);

    server.handle = request -> switch request.protocol.path {
			case "/" if(request.protocol.method == GET):
				return Response.json(200, {
					message: 'fuzzy.http hashlink webserver',
					cookies: [for(name => _ in request.cookies) name]
				})
				.header("custom-header", ["hello 🐾🐾🐾"])
				.cookie({ 
					name: "food", 
					value: "cookie cookie", 
					expiry: 99999999999999,
					js: false,
					strict: false,
				});

			case _:
				return Response.json(404, {
					message: 'not found'
				});
		};

    server.start();
  }
}