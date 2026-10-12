package fuzzy.ds;

enum Result<T, E> {
  Ok(v: T);
  Err(e: E);
}