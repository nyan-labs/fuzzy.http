package fuzzy.router.metaplugins;

import haxe.macro.Context;
import haxe.macro.ExprTools;
import haxe.macro.Expr;
import fuzzy.router.Router.Route;
import haxe.macro.Expr.ExprOf;

#if macro
class Utils {
  static public function from_eblock_to_array(block: Expr): Array<Expr> {
    switch block.expr {
      case EBlock(exprs):
        return exprs;
      case _:
        return [];
    }
  }
}
#end

class Test {
  #if macro
  static public function param(route: ExprOf<Route>, params: Array<Expr>): ExprOf<Route> {
    switch route.expr {
      case ECall(e, enum_params) if(e.expr.match(EConst(CIdent("Route")))):
        var method = enum_params[0];
        var path = enum_params[1];
        var fun = enum_params[2];

        // should be something function inline
        var regexes = macro {
          var ___route_path_regex = ~/:([A-Za-z_]+)/gi;
          var ___request_path_regex = new EReg(
            '^' + ___route_path_regex.replace(EReg.escape($path), "([^\\/]+)"),
            "i"
          );

          var ___route_path_param_names = new Array<String>();

          var ___route_path_consumable = $path;
          while(___route_path_regex.match(___route_path_consumable)) {
            ___route_path_param_names.push(
              ___route_path_regex.matched(1)
            );

            ___route_path_consumable = ___route_path_regex.matchedRight();
          }

          var ___route_path_params = new Map<String, Dynamic>();

          if(___request_path_regex.match(request.protocol.path))
          for(i => param in ___route_path_param_names) {
            ___route_path_params.set(
              param,
              ___request_path_regex.matched(i+1)
            );
          }
        };

        for(param in params) switch param.expr {
          case EVars(vars): for(v in vars) {
            var value = macro (___route_path_params.get($v{v.name}) ?? ${v.expr});
            v.expr = value;
          }
          case _: null;
        }

        var body = Utils.from_eblock_to_array(regexes)
          .concat(params)
          .concat([macro $fun(request)]);

        return macro Route($method, $path, request -> $b{body});

      case _: 
        return route;
    }
  }
  #end
}