package fuzzy.router;

import fuzzy.router.plugins.IPlugin;
import fuzzy.http.Request;
import fuzzy.http.Response;

abstract class IRouter {
  public var plugins: Array<IPlugin>;
  public function new() {
    plugins = new Array();
  }

  abstract public function handle(request: Request): Response;
}