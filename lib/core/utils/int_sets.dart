/// Small sets of 1-based positions (weekdays 1..7, months 1..12), stored in
/// SQLite as integer bit masks.
int maskOf(Set<int> items) => items.fold(0, (m, i) => m | (1 << (i - 1)));

Set<int> setOfMask(int mask, int size) => {
  for (var i = 1; i <= size; i++)
    if (mask & (1 << (i - 1)) != 0) i,
};

bool sameSet(Set<int> a, Set<int> b) =>
    a.length == b.length && a.containsAll(b);
