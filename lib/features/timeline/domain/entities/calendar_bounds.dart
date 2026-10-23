import 'package:equatable/equatable.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';

/// The days the calendar covers: from the day the app started to the end of
/// the month three months ahead.
class CalendarBounds extends Equatable {
  const CalendarBounds({required this.first, required this.last});

  static const monthsAhead = 3;

  /// How far a plan can be made from [today].
  static DateTime lastDay(DateTime today) =>
      monthEnd(DateTime(today.year, today.month + monthsAhead));

  final DateTime first, last;

  bool contains(DateTime day) => !day.isBefore(first) && !day.isAfter(last);

  bool hasMonthBefore(DateTime month) =>
      monthStart(month).isAfter(monthStart(first));

  bool hasMonthAfter(DateTime month) =>
      monthStart(month).isBefore(monthStart(last));

  /// First day of every month the calendar covers, oldest first.
  List<DateTime> get months {
    final end = monthStart(last);
    return [
      for (
        var m = monthStart(first);
        !m.isAfter(end);
        m = DateTime(m.year, m.month + 1)
      )
        m,
    ];
  }

  @override
  List<Object?> get props => [first, last];
}
