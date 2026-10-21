import 'package:flux_wallet/core/utils/group_by.dart';
import 'package:flux_wallet/features/rules/domain/entities/planned_payment.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/plan_builder.dart';

/// Planned items from today to [last], by day. Today's income is left out: it
/// is logged by hand when it arrives, so it would be counted twice.
Map<DateTime, List<PlannedPayment>> timelinePlans(
  List<RecurringRule> rules,
  DateTime today,
  DateTime last,
  ScheduleContext ctx,
) {
  final all = const PlanBuilder()(
    rules,
    from: today,
    to: last,
    ctx: ctx,
    filter: (_) => true,
  );
  final kept = all.where((p) => !(p.date == today && p.rule.isIncome));
  return groupBy(kept, (p) => p.date);
}
