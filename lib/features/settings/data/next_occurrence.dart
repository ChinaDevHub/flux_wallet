import 'package:timezone/timezone.dart' as tz;

/// The next time the clock shows [hour]:[minute] (today if still ahead).
tz.TZDateTime nextOccurrence(int hour, int minute) {
  final now = tz.TZDateTime.now(tz.local);
  final today = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    hour,
    minute,
  );
  return today.isAfter(now) ? today : today.add(const Duration(days: 1));
}
