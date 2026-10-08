package;

import fuzzy.router.EnumRouter;
import haxe.coro.Coroutine;
import fuzzy.http.Headers;
import fuzzy.http.Request;
import fuzzy.http.Request.Method;
import fuzzy.http.Response;
import sys.net.Host;

import fuzzy.router.EnumRouterMacro;
import fuzzy.router.EnumRouterMacro.meta;

class Main {
	static var router = EnumRouterMacro.from([
		// todo: stuff
		// Gate(req -> req.cookies.get("user") != null, [
		// Route(GET, "/", req -> "logged in"),
		// ]),
		// todo: this in a macro
		// (out of scope for fuzzy.http?)
		@:query(var page:Int = 0)
		@:param(var hey:String = "meow")
		@:return({
			name: String,
			version: Int
		})
		Route(GET, "/", req -> Response.json(200, {
			name: "hashlink",
			version: "idk"
		})),
		
		Route(GET, "/tist", req -> 'hi'),
		
		Route(POST, "/", req -> Response.text(200, "hi"))
	]);
    
  static function main() {
    var server = new fuzzy.http.Server(new Host("0.0.0.0"), 3000);

    // router.add(meta(
    //   @:return(String)
    //   Route(GET, "/balls", request -> "yay")
    // ));

    server.handle = router.handle;
    
    server.start();
  }
}