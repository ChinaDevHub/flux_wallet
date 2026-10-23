import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/usecases/rule_schedule_editor.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_state.dart';

/// The changes a day's panel can make. Each one writes to the database,
/// which triggers a reload by itself.
mixin TimelineEdits on Cubit<TimelineState> {
  RuleScheduleEditor get editor;

  Future<void> setSkipped(RecurringRule rule, DateTime day, bool skipped) =>
      skipped ? editor.skipOnce(rule, day) : editor.unskip(rule, day);

  Future<void> endFrom(RecurringRule rule, DateTime day) =>
      editor.endFrom(rule, day);

  Future<void> delete(RecurringRule rule) => editor.delete(rule);

  Future<void> setDayOff(DateTime day, bool off) =>
      editor.setDayOff(day, off: off);
}
