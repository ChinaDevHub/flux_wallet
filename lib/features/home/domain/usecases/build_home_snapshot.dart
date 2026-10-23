import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';
import 'package:flux_wallet/features/home/domain/usecases/calculate_daily_limit.dart';
import 'package:flux_wallet/features/home/domain/usecases/generate_daily_tip.dart';
import 'package:flux_wallet/features/home/domain/usecases/start_of_day_limit.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/plan_builder.dart';
import 'package:flux_wallet/features/rules/domain/usecases/plan_windows.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_list_x.dart';

class BuildHomeSnapshot {
  const BuildHomeSnapshot();
  HomeSnapshot call({
    required String userName,
    required DateTime today,
    required double balance,
    required List<RecurringRule> rules,
    required ScheduleContext ctx,
    required List<Transaction> todayTx,
    int pendingCount = 0,
    List<Account> accounts = const [],
  }) {
    final spent = todayTx.discretionaryExpense;
    const calc = CalculateDailyLimit();
    final limit = calc.atStartOfDay(
      balance: balance,
      spent: spent,
      rules: rules,
      today: today,
      ctx: ctx,
    );
    final budget = calc.perDay(limit);
    const plan = PlanBuilder();
    const tip = GenerateDailyTip();
    return HomeSnapshot(
      userName: userName,
      today: today,
      limit: limit,
      dailyBudget: budget,
      spentToday: spent,
      todayTransactions: todayTx,
      todayPlans: plan.today(rules, today, ctx),
      upcoming: plan.upcoming(rules, today, ctx),
      pendingCount: pendingCount,
      accounts: accounts,
      tip: tip(limit: limit, remainingToday: budget - spent),
    );
  }
}
