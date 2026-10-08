package fuzzy.log;

import plasma.Plasma;
import haxe.PosInfos;

using fuzzy.log.AnsiTools;

enum abstract Severity(String) from String to String {
  final Ok = "Ok";
  final Err = "Err";
  final Warn = "Warn";
  final Dbg = "Dbg";


  // todo: change how ridiculous this is lol
  @:op(A + B)
  function add(severity: Severity) {
    switch this {
      case Dbg:
        return 'Dbg+$severity';

      case _:
        throw 'you can only combine Dbg + Severity.*';
    }
  }

  @:op(A == B)
  function equal(severity: Severity) {
    switch this {
      case Dbg if(StringTools.startsWith(severity, "Dbg+")):
        return true;

      case _:
        return this == severity;
    }
  }
}

class Logger {
  var colored: Bool = false;

  final name: String;
  
  public function new(name: String) {
    this.name = name;
  }

  var stdout = Sys.stdout();
  inline public function log(severity: Severity, message: String, ?posinfos: PosInfos) {
    // disable debug severity logs
    #if !fuzzy.log.debug if(severity == Dbg) return; #end

    // only log via haxe's trace
    #if fuzzy.log.trace
    haxe.Log.trace(message, posinfos);
    #else
    var content = '';
    // log the source file, like how trace does it
    #if fuzzy.log.sourceline 
    content += ':. ${posinfos?.fileName}:${posinfos?.lineNumber}\n'.fg_hex(0xC2FF3E).dim(); 
    #end

    var name = name.dim();

    content += '$name::${style_severity(severity)} $message\n';
    
    stdout.writeString(content);
    stdout.flush();
    #end
  }

  inline function style_severity(severity: Severity) {
    return switch severity {
      case Err:
        'Err'.fg_hex(0xE72D2D);
      case Warn:
        'Warn'.fg_hex(0xF8AD19);
      case Ok:
        'Ok'.fg_hex(0x1CE1FF);
      case Dbg:
        'Dbg'.fg_hex(0xC2FF3E);
      case severity if(StringTools.contains(severity, "+")): 
        [for(severity in (severity: String).split("+")) {
          style_severity(severity);
        }].join("+");

      case severity:
        severity.bold();
    }
  }
}