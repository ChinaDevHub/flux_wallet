import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/planned_payment.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/plan_builder.dart';
import 'package:flux_wallet/features/rules/domain/usecases/plan_windows.dart';

class NextIncomeFinder {
  const NextIncomeFinder();

  static const _horizonDays = 400;
  static const _plan = PlanBuilder();

  /// Earliest income occurrence strictly after [today], or null.
  PlannedPayment? nextPayment(
    List<RecurringRule> rules,
    DateTime today, [
    ScheduleContext ctx = ScheduleContext.empty,
  ]) {
    final to = addDays(today, _horizonDays);
    return _plan.income(rules, addDays(today, 1), to, ctx).firstOrNull;
  }

  DateTime? call(
    List<RecurringRule> rules,
    DateTime today, [
    ScheduleContext ctx = ScheduleContext.empty,
  ]) => nextPayment(rules, today, ctx)?.date;

  /// Latest income occurrence on or before [today], or null.
  DateTime? previous(
    List<RecurringRule> rules,
    DateTime today, [
    ScheduleContext ctx = ScheduleContext.empty,
  ]) {
    final from = addDays(today, -_horizonDays);
    return _plan.income(rules, from, today, ctx).lastOrNull?.date;
  }
}
