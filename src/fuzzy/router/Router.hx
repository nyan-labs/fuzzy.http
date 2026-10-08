package fuzzy.router;

import fuzzy.http.Request;
import fuzzy.http.Response;

abstract class Router {
  public function new() {}

  abstract public function handle(request: Request): Response;
}