package fuzzy.router;

import haxe.Rest;
import fuzzy.router.Router;

class RouterTools {
  inline static public function array<T: Router>(router: Class<T>, routes: Routes): T {
    var router = Type.createInstance(router, []);
    @:privateAccess router.routes = routes;

    return router;
  }
  
  inline static public function rest<T: Router>(router: Class<T>, rest: Rest<Route>): T {
    var router = Type.createInstance(router, []);
    @:privateAccess router.routes = rest.toArray();

    return router;
  }
}