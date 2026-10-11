package;

import fuzzy.router.metaplugins.Test;
import fuzzy.http.Request;
import fuzzy.router.plugins.IPlugin;
import fuzzy.router.Router;
import hl.Gc;
import fuzzy.router.Router;
import haxe.coro.Coroutine;
import fuzzy.http.Headers;
import fuzzy.http.Request;
import fuzzy.http.Request.Method;
import fuzzy.http.Response;
import sys.net.Host;

using fuzzy.router.RouterMacro;

class CustomRouter<RF = RouteFun<Request>> extends Router implements IPlugin {
	static var ___meta = [
		":param" => untyped Test.param
	];
}

class Main {
	static var router = CustomRouter.rest(
		@:param(var name: String = "meow")
		@:return({
			name: String,
			version: Int
		})
		Route(GET, "/:name", req -> Response.json(200, {
			name: 'hashlink' + /*name +*/ req.body,
			version: "idk"
		})),
		
		Route(POST, "/", req -> Response.text(200, "hi"))
	);
    
  static function main() {
    var server = new fuzzy.http.Server(new Host("0.0.0.0"), 3000);

    // router.add(meta(
    //   @:return(String)
    //   Route(GET, "/balls", request -> "yay")
    // ));

    server.handle = router.handle;
    
    server.start();

		// @:plugin()
		// @:metaplugin()
		// var ruter = new Router();

		// @:query(var page: Int = 0)
		// ruter.get("/stuff", request -> {
			
		// });
  }
}