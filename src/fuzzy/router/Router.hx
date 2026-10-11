package fuzzy.router;

import haxe.Rest;
import fuzzy.http.Response;
import fuzzy.http.Request;
import fuzzy.http.Request.Method;

typedef RouteFun<R = Request> = R->Response;

enum Route {
  Route(method: Method, path: String, fun: RouteFun);

  Gate(condition: Request->Bool, routes: Routes);

  Middleware(); // for macro, we will just wrap it in this thingy, so we dont lose runtime thingies
}

typedef Routes = Array<Route>;

class Router<RF: RouteFun = RouteFun<Request>> extends IRouter {
  var routes: Routes;

  dynamic public function NOT_FOUND()
    return Response.text(NotFound, "not found");

  public function new() {
    super();

    routes = new Array();
  }
  
  public function add(rest: Rest<Route>) {
    routes = routes.concat(rest.toArray());
    return this;
  }

  public function handle(request: Request): Response {
    for(route in routes) 
      switch route {
        case Route(method, path, fun) if(request.protocol.method == method/* && request.protocol.path == path*/):
          return fun(request);

        case _:
          continue;
      }

    return NOT_FOUND();
  }
}