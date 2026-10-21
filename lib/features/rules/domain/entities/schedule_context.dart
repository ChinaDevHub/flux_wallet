import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

/// Everything besides the rule itself that decides whether it happens on a
/// given day: "işə getmirəm" days and per-rule skipped dates.
class ScheduleContext extends Equatable {
  const ScheduleContext({this.offDays = const {}, this.exceptions = const {}});

  static const empty = ScheduleContext();

  final Set<DateTime> offDays;

  /// ruleId -> skipped dates.
  final Map<int, Set<DateTime>> exceptions;

  bool isSkipped(RecurringRule rule, DateTime day) =>
      exceptions[rule.id]?.contains(day) ?? false;

  @override
  List<Object?> get props => [offDays, exceptions];
}
