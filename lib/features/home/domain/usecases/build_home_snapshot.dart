import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';
import 'package:flux_wallet/features/home/domain/usecases/generate_daily_tip.dart';
import 'package:flux_wallet/features/home/domain/usecases/home_budget.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/plan_builder.dart';
import 'package:flux_wallet/features/rules/domain/usecases/plan_windows.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_list_x.dart';

/// Pure assembly of everything the home screen shows.
HomeSnapshot buildHomeSnapshot({
  required String userName,
  required DateTime today,
  required double balance,
  required List<RecurringRule> rules,
  required ScheduleContext ctx,
  required List<Transaction> todayTx,
  int pendingCount = 0,
  List<Account> accounts = const [],
  double? cap,
}) {
  final spent = todayTx.discretionaryExpense;
  final (:limit, :budget) = homeBudget(
    balance: balance,
    spent: spent,
    rules: rules,
    today: today,
    ctx: ctx,
    cap: cap,
  );
  return HomeSnapshot(
    userName: userName,
    today: today,
    limit: limit,
    dailyBudget: budget,
    spentToday: spent,
    todayTransactions: todayTx,
    todayPlans: const PlanBuilder().today(rules, today, ctx),
    upcoming: const PlanBuilder().upcoming(rules, today, ctx),
    pendingCount: pendingCount,
    accounts: accounts,
    tip: const GenerateDailyTip()(limit: limit, remainingToday: budget - spent),
  );
}
