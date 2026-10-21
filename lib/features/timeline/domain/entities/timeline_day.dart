import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';

class TimelineDay extends Equatable {
  const TimelineDay({
    required this.date,
    required this.entries,
    required this.endBalance,
    required this.isToday,
    required this.isPast,
    required this.isDayOff,
  });

  final DateTime date;
  final List<TimelineEntry> entries;

  /// Balance at the end of the day: history before today, forecast after.
  final double endBalance;
  final bool isToday, isPast, isDayOff;

  bool get hasIncome => entries.any((e) => e.isIncome);
  bool get hasExpense => entries.any((e) => !e.isIncome);

  @override
  List<Object?> get props => [
    date,
    entries,
    endBalance,
    isToday,
    isPast,
    isDayOff,
  ];
}
