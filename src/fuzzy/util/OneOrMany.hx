package fuzzy.util;

/**
  turns a singular item into an item array, and many items stay the same
**/
@:forward
abstract OneOrMany<T>(Array<T>) from Array<T> to Array<T> {
  function new(t: Array<T>)
    this = t;

  @:from static function one<T>(t: T)
    return new OneOrMany([t]);
  @:from static function many<T>(t: Array<T>)
    return new OneOrMany(t);

  @:to function to(): Array<T>
    return this;
}