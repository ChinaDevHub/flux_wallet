import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/timeline/domain/entities/calendar_bounds.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_view.dart';

sealed class TimelineState extends Equatable {
  const TimelineState();

  @override
  List<Object?> get props => const [];
}

class TimelineLoading extends TimelineState {
  const TimelineLoading();
}

class TimelineFailure extends TimelineState {
  const TimelineFailure();
}

/// One month of the calendar and the day picked in it.
class TimelineLoaded extends TimelineState {
  const TimelineLoaded({
    required this.view,
    required this.bounds,
    required this.selected,
    required this.today,
  });

  final TimelineView view;
  final CalendarBounds bounds;

  /// The picked day, always inside [view]'s month.
  final DateTime selected;

  /// The day it is now.
  final DateTime today;

  DateTime get month => view.month;

  TimelineDay get selectedDay =>
      view.days.firstWhere((d) => d.date == selected);

  TimelineLoaded withSelected(DateTime day) =>
      TimelineLoaded(view: view, bounds: bounds, selected: day, today: today);

  @override
  List<Object?> get props => [view, bounds, selected, today];
}
