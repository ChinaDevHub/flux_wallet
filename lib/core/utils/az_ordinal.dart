/// "25-i", "3-ü", "20-si": the Azerbaijani possessive suffix depends on how
/// the number is pronounced.
String azDayOrdinal(int day) {
  const byDigit = {
    1: 'i',
    2: 'si',
    3: 'ü',
    4: 'ü',
    5: 'i',
    6: 'sı',
    7: 'si',
    8: 'i',
    9: 'u',
  };
  const round = {10: 'u', 20: 'si', 30: 'u'};
  return '$day-${round[day] ?? byDigit[day % 10]}';
}
