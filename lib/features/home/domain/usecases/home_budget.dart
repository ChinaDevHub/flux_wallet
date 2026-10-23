import 'package:flux_wallet/features/budget/domain/usecases/daily_cap.dart';
import 'package:flux_wallet/features/home/domain/entities/daily_limit.dart';
import 'package:flux_wallet/features/home/domain/usecases/calculate_daily_limit.dart';
import 'package:flux_wallet/features/home/domain/usecases/start_of_day_limit.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';

/// Today's limit as it stood this morning, and the amount the user may
/// spend today: the app's per-day share, lowered to the personal [cap].
({DailyLimit limit, double budget}) homeBudget({
  required double balance,
  required double spent,
  required List<RecurringRule> rules,
  required DateTime today,
  required ScheduleContext ctx,
  double? cap,
}) {
  const calc = CalculateDailyLimit();
  final limit = calc.atStartOfDay(
    balance: balance,
    spent: spent,
    rules: rules,
    today: today,
    ctx: ctx,
  );
  return (limit: limit, budget: DailyCap.effective(calc.perDay(limit), cap));
}
