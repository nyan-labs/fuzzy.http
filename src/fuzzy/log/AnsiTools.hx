package fuzzy.log;

@:publicFields
class AnsiTools {
  #if plasma
  static final color = new plasma.Plasma({level: TRUE_COLOR});

  inline static function fg_hex(s: String, hex: plasma.haxe.EitherType<Int, String>)
    return color.hex(hex).apply(s);

  inline static function bg_hex(s: String, hex: plasma.haxe.EitherType<Int, String>)
    return color.bgHex(hex).apply(s);

  inline static function bold(s: String)
    return color.bold.apply(s);

  inline static function dim(s: String)
    return color.dim.apply(s);
  #else
  inline static function fg_hex(s: String, hex: Dynamic)
    return s;

  inline static function bg_hex(s: String, hex: Dynamic)
    return s;

  inline static function bold(s: String)
    return s;

  inline static function dim(s: String)
    return s;
  #end
}