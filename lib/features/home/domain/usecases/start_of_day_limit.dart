import 'package:flux_wallet/features/home/domain/entities/daily_limit.dart';
import 'package:flux_wallet/features/home/domain/usecases/calculate_daily_limit.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/next_income_finder.dart';

extension StartOfDayLimit on CalculateDailyLimit {
  /// Today's limit as it stood before today's [spent] left the balance, so the
  /// budget stays stable during the day and only what remains of it drops.
  DailyLimit atStartOfDay({
    required double balance,
    required double spent,
    required List<RecurringRule> rules,
    required DateTime today,
    required ScheduleContext ctx,
  }) => this(
    totalBalance: balance + spent,
    rules: rules,
    today: today,
    nextIncome: const NextIncomeFinder()(rules, today, ctx),
    ctx: ctx,
  );
}
