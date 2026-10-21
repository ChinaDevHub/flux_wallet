import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/planned_payment.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/plan_builder.dart';

/// The two windows the home screen cares about.
extension PlanWindows on PlanBuilder {
  /// Mandatory payments planned for today (shown in the "Bu gün" list).
  List<PlannedPayment> today(
    List<RecurringRule> rules,
    DateTime today,
    ScheduleContext ctx,
  ) =>
      this(rules, from: today, to: today, ctx: ctx, filter: (r) => !r.isIncome);

  /// Monthly bills and income within the next [days] days ("Qarşıda").
  List<PlannedPayment> upcoming(
    List<RecurringRule> rules,
    DateTime today,
    ScheduleContext ctx, {
    int days = 14,
  }) => this(
    rules,
    from: addDays(today, 1),
    to: addDays(today, days),
    ctx: ctx,
    filter: (r) => r.frequency == Frequency.monthly,
  );

  /// Income occurrences only (salary, ...) inside `[from, to]`.
  List<PlannedPayment> income(
    List<RecurringRule> rules,
    DateTime from,
    DateTime to,
    ScheduleContext ctx,
  ) => this(rules, from: from, to: to, ctx: ctx, filter: (r) => r.isIncome);
}
