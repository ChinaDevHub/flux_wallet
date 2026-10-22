typedef Clock = DateTime Function();

DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

DateTime addDays(DateTime d, int days) =>
    DateTime(d.year, d.month, d.day + days);

/// Whole calendar days from [a] to [b] (DST safe).
int daysBetween(DateTime a, DateTime b) => DateTime.utc(
  b.year,
  b.month,
  b.day,
).difference(DateTime.utc(a.year, a.month, a.day)).inDays;

/// [d] limited to the range [lo]..[hi].
DateTime clampDate(DateTime d, DateTime lo, DateTime hi) =>
    d.isBefore(lo) ? lo : (d.isAfter(hi) ? hi : d);

DateTime monthStart(DateTime d) => DateTime(d.year, d.month);

DateTime monthEnd(DateTime d) => DateTime(d.year, d.month + 1, 0);

int daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

/// ISO yyyy-MM-dd, used as a sortable day key in SQLite.
String dayKey(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';
