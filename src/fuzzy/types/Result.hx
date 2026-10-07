package fuzzy.types;

enum Result<T, E> {
  Ok(v: T);
  Err(e: E);
}