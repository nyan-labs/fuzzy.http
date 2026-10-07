package fuzzy.http;

enum abstract HeaderName(String) from String to String {
  final ContentType = "content-type";
  final ContentLength = "content-length";
}

@:forward
abstract Headers(Map<HeaderName, String>) {
  public function new(?map) {
    this = map ?? new Map();
  }

  @:to public function string() {
    var string = '';

    for(name => value in this) {
      string += '$name: $value\r\n'; // sanitization needed! i tink.
    }

    return string;
  }

  @:from static public function map(map: Map<HeaderName, String>) {
    return new Headers(map);
  }
}