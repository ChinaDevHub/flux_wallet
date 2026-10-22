/// Built-in guesses used until the user teaches the app a merchant.
/// A word matches a merchant when one of its words equals / starts with it.
const merchantHints = <String, List<String>>{
  'taxi': ['BOLT', 'UBER', 'YANGO', 'TAXI', 'TAKSI'],
  'bus': ['BAKUBUS', 'BAKICARD', 'METRO'],
  'grocery': [
    'BRAVO',
    'ARAZ',
    'MARKET',
    'OBA',
    'BOLMART',
    'RAHAT',
    'SUPERMARKET',
  ],
  'cafe': [
    'CAFE',
    'KAFE',
    'COFFEE',
    'RESTAURANT',
    'PIZZA',
    'BURGER',
    'STARBUCKS',
    'KFC',
  ],
  'fuel': ['SOCAR', 'LUKOIL', 'SHELL', 'PETROL', 'AZPETROL'],
  'utilities': ['AZERSU', 'AZERISIQ', 'AZERIQAZ', 'AZERCELL', 'BAKCELL', 'NAR'],
};

String? hintCategory(String key) {
  final words = key.split(' ');
  for (final entry in merchantHints.entries) {
    final hit = entry.value.any(
      (hint) => words.any(
        (w) => w == hint || (hint.length >= 4 && w.startsWith(hint)),
      ),
    );
    if (hit) return entry.key;
  }
  return null;
}
