import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/usecases/rule_schedule_editor.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/load_timeline.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_state.dart';

class TimelineCubit extends ReloadingCubit<TimelineState> {
  TimelineCubit(this._load, this._editor, Stream<void> changes)
    : super(const TimelineLoading(), changes);

  final LoadTimeline _load;
  final RuleScheduleEditor _editor;
  int _monthOffset = 0;

  @override
  Future<void> load() async {
    try {
      emit(TimelineLoaded(await _load(_monthOffset), _monthOffset));
    } catch (_) {
      emit(const TimelineFailure());
    }
  }

  Future<void> selectMonth(int offset) {
    _monthOffset = offset;
    return load();
  }

  // Each edit writes to the database, which triggers a reload by itself.
  Future<void> skipOnce(RecurringRule rule, DateTime day) =>
      _editor.skipOnce(rule, day);

  Future<void> endFrom(RecurringRule rule, DateTime day) =>
      _editor.endFrom(rule, day);

  Future<void> setDayOff(DateTime day, bool off) =>
      _editor.setDayOff(day, off: off);
}
