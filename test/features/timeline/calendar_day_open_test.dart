import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/timeline/domain/entities/calendar_bounds.dart';
import 'package:flux_wallet/features/timeline/domain/entities/calendar_day_open.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';

TimelineDay day(int d, {bool past = true, bool active = false}) => TimelineDay(
  date: DateTime(2026, 10, d),
  entries: [
    if (active) const TimelineEntry(category: 'cafe', signedAmount: -5),
  ],
  endBalance: 0,
  isToday: !past && d == 24,
  isPast: past,
  isDayOff: false,
);

void main() {
  final bounds = CalendarBounds(
    first: DateTime(2026, 10, 5),
    last: DateTime(2027, 1, 31),
  );

  test('a past day opens only when something happened on it', () {
    expect(bounds.opens(day(10)), isFalse);
    expect(bounds.opens(day(10, active: true)), isTrue);
  });

  test('today and the days ahead always open; before the first never', () {
    expect(bounds.opens(day(24, past: false)), isTrue);
    expect(bounds.opens(day(30, past: false)), isTrue);
    expect(bounds.opens(day(3, active: true)), isFalse);
  });
}
