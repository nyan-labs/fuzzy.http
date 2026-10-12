package;

import fuzzy.http.Request;
import fuzzy.http.Headers;
import fuzzy.http.Request;
import fuzzy.http.Request.Method;
import fuzzy.http.Response;
import sys.net.Host;

class Main {	
  static function main() {
    var server = new fuzzy.http.Server(new Host("0.0.0.0"), 3000);

    server.handle = request -> switch request.protocol.path {
			case "/" if(request.protocol.method == GET):
				return Response.json(200, {
					message: 'fuzzy.http hashlink webserver'
				});

			case _:
				return Response.json(404, {
					message: 'not found'
				});
		};

    server.start();

		// @:plugin()
		// @:metaplugin()
		// var ruter = new Router();

		// @:query(var page: Int = 0)
		// ruter.get("/stuff", request -> {
			
		// });
  }
}