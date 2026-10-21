Map<K, List<T>> groupBy<T, K>(Iterable<T> items, K Function(T) key) {
  final map = <K, List<T>>{};
  for (final item in items) {
    (map[key(item)] ??= []).add(item);
  }
  return map;
}
