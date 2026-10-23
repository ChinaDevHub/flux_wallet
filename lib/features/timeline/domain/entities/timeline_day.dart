import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/timeline/domain/entities/day_limit.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';

class TimelineDay extends Equatable {
  const TimelineDay({
    required this.date,
    required this.entries,
    required this.endBalance,
    required this.isToday,
    required this.isPast,
    required this.isDayOff,
    this.limit,
  });

  final DateTime date;
  final List<TimelineEntry> entries;

  /// Balance at the end of the day: history before today, forecast after.
  final double endBalance;
  final bool isToday, isPast, isDayOff;

  /// Spending against the limit; null for days that have not come yet.
  final DayLimit? limit;

  bool get isOver => limit?.isOver ?? false;
  bool get isFuture => !isPast && !isToday;
  bool get hasIncome => entries.any((e) => e.counts && e.isIncome);
  bool get hasExpense => entries.any((e) => e.counts && !e.isIncome);

  @override
  List<Object?> get props => [
    date, entries, endBalance, isToday, isPast, isDayOff, limit, //
  ];
}
