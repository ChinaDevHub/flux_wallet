import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/rules/domain/entities/pause_range.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

/// Everything besides the rule itself that decides whether it happens on a
/// given day: "işə getmirəm" days, per-rule skipped dates and the stretches
/// a rule was switched off.
class ScheduleContext extends Equatable {
  const ScheduleContext({
    this.offDays = const {},
    this.exceptions = const {},
    this.pauses = const {},
  });

  static const empty = ScheduleContext();

  final Set<DateTime> offDays;

  /// ruleId -> skipped dates.
  final Map<int, Set<DateTime>> exceptions;

  /// ruleId -> the stretches it was switched off.
  final Map<int, List<PauseRange>> pauses;

  bool isPaused(RecurringRule rule, DateTime day) =>
      pauses[rule.id]?.any((p) => p.covers(day)) ?? false;

  bool isExcepted(RecurringRule rule, DateTime day) =>
      exceptions[rule.id]?.contains(day) ?? false;

  bool isSkipped(RecurringRule rule, DateTime day) =>
      isExcepted(rule, day) || isPaused(rule, day);

  /// The same context with single-day skips forgotten, to list what a day
  /// would hold if nothing had been switched off for it.
  ScheduleContext withoutExceptions() =>
      ScheduleContext(offDays: offDays, pauses: pauses);

  @override
  List<Object?> get props => [offDays, exceptions, pauses];
}
