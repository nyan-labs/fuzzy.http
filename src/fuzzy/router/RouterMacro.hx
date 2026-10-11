package fuzzy.router;

import haxe.macro.TypeTools;
import haxe.macro.Type.TypedExpr;
import haxe.macro.TypedExprTools;
import haxe.macro.Compiler;
import haxe.extern.Rest;
import fuzzy.router.Router.Route;
import haxe.macro.ExprTools;
import haxe.macro.Context;
import haxe.macro.Expr;
import fuzzy.router.Router.Routes;
import fuzzy.http.Response;
import fuzzy.http.Request;
import fuzzy.http.Request.Method;

class RouterMacro {
  #if macro
  inline static function read(route: ExprOf<Route>, metaplugins: Map<String, ExprOf<Route>->Array<Expr>->Expr> = [], meta: Array<MetadataEntry> = []) {
    switch route.expr {
      case EMeta(s, e):
        meta.push(s);
        return read(e, metaplugins, meta);

      // enum
      case ECall(_, _):
        for(m in meta) {
          var metaplugin = metaplugins.get(m.name); 
          if(metaplugin != null) {
            // metaplugin
            var r = metaplugin(route, m.params);
            route = r;

            // var got = Context.resolveType(TPath());
          } else Context.warning('unknown route metadata ${m.name}', m.pos);
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
  static public macro function array(router: ExprOf<Class<Router>>, routes: ExprOf<Routes>): Expr {
    var routes = switch routes.expr {
      case EArrayDecl(values):
        {
          expr: EArrayDecl([
            for(value in values)
              RouterMacro.read(value)
          ]),
          pos: routes.pos
        };

      case e: 
        Context.error('expected an array, got $e', Context.currentPos());
    }

    return macro fuzzy.router.RouterTools.array($router, $routes);
  }

  static public macro function rest(router: ExprOf<Class<Router>>, routes: Rest<ExprOf<Route>>): Expr {
    var class_type = switch router.expr {
      case EMeta({name: ":storedTypedExpr"}, e):
        var typed_expr = Context.typeExpr(router);

        switch typed_expr.expr {
          case TTypeExpr(TClassDecl(c)): c.get();

          case _: 
            throw Context.error('expected class, got ${ExprTools.toString(router)}', Context.currentPos());
        }

      case EConst(CIdent(s)):
        TypeTools.getClass(Context.getType(s));
      
      case _: 
        throw Context.error('expected class, got ${ExprTools.toString(router)}', router.pos);
    }
    
    
    var package_path = class_type.pack.concat([class_type.module, class_type.name]).join("."); 

    // does not work, TODO!!!!
    // var ass = switch Type.resolveClass(package_path) {
    //   case ass if(ass == null):
    //     Context.error('invalid package path $package_path', router.pos);

    //   case ass: ass;
    // }
    // trace(ass);

    var metaplugins: Map<String, ExprOf<Route>->Array<Expr>->Expr> = new Map();

    // Context.warning('$a $class_type', router.pos);

    // switch class_type {
    //   case TType(t, params):
    //     var a = switch t.get().type {
    //       case TAnonymous(a):
    //         a.get().fields

    //       case _: null;
    //     }
    //     Context.warning('$a', router.pos);

      // case _: null;
    // }


    var instance = macro Type.createInstance($router, []);

    var parsed: Array<ExprOf<Route>> = new Array();

    for(route in routes) {
      parsed.push(
        RouterMacro.read(route, metaplugins)
      );
    }

    return macro $instance.add($a{parsed});
  }
}