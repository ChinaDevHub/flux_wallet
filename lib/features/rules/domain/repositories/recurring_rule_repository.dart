import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

abstract interface class RecurringRuleRepository {
  /// Every rule, including ones that ended or are switched off: their days
  /// before that still count as history (see `ScheduleContext.pauses`).
  Future<List<RecurringRule>> getAll();
  Future<int> add(RecurringRule rule);
  Future<void> update(RecurringRule rule);

  /// Removes the rule and everything hanging on it. Only for a rule that
  /// never ran; one with history is ended instead.
  Future<void> delete(int id);

  /// Switches the rule off from [day] on, or back on from [day] on; the days
  /// before are untouched.
  Future<void> setEnabled(
    int id, {
    required bool enabled,
    required DateTime day,
  });

  /// A changed schedule from [from] on: [old] ends the day before and [next]
  /// takes over (with the skips and the switched-off state that were ahead).
  Future<void> revise(RecurringRule old, RecurringRule next, DateTime from);
}
