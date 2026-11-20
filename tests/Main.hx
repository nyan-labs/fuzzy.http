package;

import fuzzy.http.Response;
import sys.net.Host;

using Std;

class Main {	
  static function main() {
    var server = new fuzzy.http.Server(new Host("0.0.0.0"), 3000);

    server.handle = request -> switch [request.protocol.method, request.protocol.path] {
			case [any, "/"]:
				return Response.json(OK, {
					message: 'fuzzy.http hashlink webserver',
					a: request.cookies
				}).cookie({
					name: "youve-been-here-before",
					value: (request.cookies.get("youve-been-here-before")?.value.parseInt() + 1).string()
				});

			case _:
				return Response.json(404, {
					message: 'not found'
				});
		};

		trace('started http server at http://${server.host}:${server.port}/');
    server.start();
  }
}