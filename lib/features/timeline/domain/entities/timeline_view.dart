import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/timeline/domain/entities/income_cycle.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';

class TimelineView extends Equatable {
  const TimelineView({
    required this.month,
    required this.days,
    required this.cycle,
    required this.lowest,
  });

  final DateTime month;
  final List<TimelineDay> days;
  final IncomeCycle? cycle;

  /// The day with the smallest forecast balance before the next income.
  final TimelineDay? lowest;

  /// Yesterday first: how a sliver growing upwards from today lays them out.
  List<TimelineDay> get pastDays =>
      days.where((d) => d.isPast).toList().reversed.toList();

  List<TimelineDay> get upcomingDays => days.where((d) => !d.isPast).toList();

  @override
  List<Object?> get props => [month, days, cycle, lowest];
}
