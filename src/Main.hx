import fuzzy.http.Headers;
import fuzzy.http.Request;
import fuzzy.http.Request.Method;
import fuzzy.http.Response;
import sys.net.Host;

enum Route {
  Route(method: Method, path: String, fun: Request->Response);

  Gate(condition: Request->Bool, routes: Array<Route>);
}

class Main {
  static function main() {
    var server = new fuzzy.http.Server(new Host("0.0.0.0"), 3000);

    var routes = [
      // todo: stuff
      // Gate(req -> req.cookies.get("user") != null, [
        // Route(GET, "/", req -> "logged in"),
      // ]),

      // todo: this in a macro
      @:query(var page: Int = 0)
      @:param(var hey: String = "meow")
      @:return({
        name: String,
        version: Int
      })
      Route(GET, "/", req -> Response.json(200, {
        name: "hashlink",
        version: "idk"
      }))
    ];

    server.handle = (request) -> {
      for(route in routes) switch route {
        case Route(method, path, fun) if(request.method == method && request.path == path):
          return fun(request);
        
        case _:
          continue;
      }

      return Response.text(NotFound, "404");
    }
    
    server.start();
  }
}