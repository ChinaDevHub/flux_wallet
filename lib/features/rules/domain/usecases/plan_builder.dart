import 'package:flux_wallet/features/rules/domain/entities/planned_payment.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/recurrence_expander.dart';

/// Concrete, date-sorted occurrences of the rules accepted by [filter].
class PlanBuilder {
  const PlanBuilder([this._expander = const RecurrenceExpander()]);

  final RecurrenceExpander _expander;

  List<PlannedPayment> call(
    List<RecurringRule> rules, {
    required DateTime from,
    required DateTime to,
    required ScheduleContext ctx,
    required bool Function(RecurringRule) filter,
  }) {
    final plans = [
      for (final r in rules.where(filter))
        for (final d in _expander.expand(r, from, to, ctx: ctx))
          PlannedPayment(rule: r, date: d),
    ];
    return plans..sort((a, b) => a.date.compareTo(b.date));
  }
}
