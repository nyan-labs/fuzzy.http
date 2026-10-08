package fuzzy.router;

import fuzzy.router.EnumRouter.Route;
import haxe.macro.ExprTools;
import haxe.macro.Context;
import haxe.macro.Expr;
import fuzzy.router.EnumRouter.Routes;
import fuzzy.http.Response;
import fuzzy.http.Request;
import fuzzy.http.Request.Method;

class EnumRouterMacro {
  #if macro
  inline static function read(route: ExprOf<Route>, meta: Array<MetadataEntry> = []) {
    switch route.expr {
      case EMeta(s, e):
        meta.push(s);
        return read(e, meta);

      // enum
      case ECall(_, _):
        for(m in meta)
          switch m.name {
            case name:
              Context.warning('unknown route metadata $name', m.pos);
          }
        return route;

      case e:
        Context.warning('got ${ExprTools.toString(route)}', route.pos);
        return route;
    }
  }
  #end

  /** parses a route (enum) that has an annotated metadata **/
  static public macro function meta(route: ExprOf<Route>) {
    return read(route);
  }


  /** parses routes (enums) that have an annotated metadatas and spits out a new router **/
  static public macro function from(routes: ExprOf<Routes>): ExprOf<EnumRouter> {
    var routes = switch routes.expr {
      case EArrayDecl(values):
        {
          expr: EArrayDecl([
            for(value in values)
              EnumRouterMacro.read(value)
          ]),
          pos: routes.pos
        };

      case e: 
        Context.error('expected an array, got $e', Context.currentPos());
    }

    return macro EnumRouter.from($routes);
  }
}