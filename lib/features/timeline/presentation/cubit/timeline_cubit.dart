import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/usecases/rule_schedule_editor.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/load_calendar_bounds.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/load_timeline.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/calendar_navigation.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/calendar_selection.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_edits.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_state.dart';

/// The calendar: which month is shown and which day is picked. It reloads
/// whenever data changes.
class TimelineCubit extends ReloadingCubit<TimelineState>
    with TimelineEdits, CalendarNavigation {
  TimelineCubit(
    this._load,
    this._bounds,
    this.editor,
    this._clock,
    Stream<void> changes,
  ) : super(const TimelineLoading(), changes);

  final LoadTimeline _load;
  final LoadCalendarBounds _bounds;
  @override
  final RuleScheduleEditor editor;
  final Clock _clock;
  @override
  final cursor = CalendarCursor();

  @override
  Future<void> load() async {
    try {
      final today = dateOnly(_clock());
      final bounds = await _bounds();
      final month = cursor.monthFor(today);
      emit(
        TimelineLoaded(
          view: await _load(month),
          bounds: bounds,
          selected: cursor.selectedIn(month, bounds, today),
          today: today,
        ),
      );
    } catch (_) {
      emit(const TimelineFailure());
    }
  }
}
