import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';
import 'package:flux_wallet/features/home/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/home/domain/entities/transaction.dart';
import 'package:flux_wallet/features/home/domain/usecases/calculate_daily_limit.dart';
import 'package:flux_wallet/features/home/domain/usecases/generate_daily_tip.dart';
import 'package:flux_wallet/features/home/domain/usecases/next_income_finder.dart';
import 'package:flux_wallet/features/home/domain/usecases/plan_builder.dart';
import 'package:flux_wallet/features/home/domain/usecases/plan_windows.dart';

/// Pure assembly of everything the home screen shows.
class BuildHomeSnapshot {
  const BuildHomeSnapshot();

  HomeSnapshot call({
    required String userName,
    required DateTime today,
    required double balance,
    required List<RecurringRule> rules,
    required Set<DateTime> offDays,
    required List<Transaction> todayTx,
  }) {
    final spent = todayTx.totalExpense;
    const calc = CalculateDailyLimit();
    // The balance already lost today's spending; add it back so the budget
    // stays stable during the day and only `remainingToday` drops.
    final limit = calc(
      totalBalance: balance + spent,
      rules: rules,
      today: today,
      nextIncome: const NextIncomeFinder()(rules, today),
      offDays: offDays,
    );
    final budget = calc.perDay(limit);
    const plan = PlanBuilder();
    return HomeSnapshot(
      userName: userName,
      today: today,
      limit: limit,
      dailyBudget: budget,
      spentToday: spent,
      todayTransactions: todayTx,
      todayPlans: plan.today(rules, today, offDays),
      upcoming: plan.upcoming(rules, today, offDays),
      tip: const GenerateDailyTip()(
        limit: limit,
        remainingToday: budget - spent,
      ),
    );
  }
}
