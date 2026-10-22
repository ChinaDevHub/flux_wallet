final _dateTime = RegExp(
  r'(\d{1,2})\.(\d{1,2})(?:\.(\d{2,4}))?\s+(\d{1,2}):(\d{2})',
);
final _dateOnly = RegExp(r'(\d{1,2})\.(\d{1,2})\.(\d{4})');

/// "20.10 08:42" / "20.10.2026 08:42" / "20.10.2026"; null if there is none.
/// A date without a year means the latest such day not after [now].
DateTime? extractOccurredAt(String text, DateTime now) {
  for (final m in _dateTime.allMatches(text)) {
    final date = _build(m, now, hour: m.group(4), minute: m.group(5));
    if (date != null) return date;
  }
  final m = _dateOnly.firstMatch(text);
  return m == null ? null : _build(m, now, hour: '12', minute: '0');
}

DateTime? _build(RegExpMatch m, DateTime now, {String? hour, String? minute}) {
  final day = int.parse(m.group(1)!), month = int.parse(m.group(2)!);
  final h = int.parse(hour!), min = int.parse(minute!);
  if (month < 1 || month > 12 || day < 1 || day > 31 || h > 23 || min > 59) {
    return null;
  }
  final raw = m.group(3);
  var year = raw == null
      ? now.year
      : (raw.length == 2 ? 2000 + int.parse(raw) : int.parse(raw));
  var date = DateTime(year, month, day, h, min);
  if (raw == null && date.isAfter(now.add(const Duration(days: 1)))) {
    date = DateTime(year - 1, month, day, h, min);
  }
  return date;
}
