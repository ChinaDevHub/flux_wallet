import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/budget/domain/usecases/daily_cap.dart';
import 'package:flux_wallet/features/debts/domain/usecases/load_planning_rules.dart';
import 'package:flux_wallet/features/rules/domain/usecases/load_schedule_context.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_view.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/build_timeline.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/account_repository.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/transaction_repository.dart';

class LoadTimeline {
  const LoadTimeline({
    required this.accounts,
    required this.transactions,
    required this.planning,
    required this.schedule,
    required this.cap,
    required this.clock,
  });

  final AccountRepository accounts;
  final TransactionRepository transactions;
  final LoadPlanningRules planning;
  final LoadScheduleContext schedule;
  final DailyCap cap;
  final Clock clock;

  /// The month containing [month]. History is rebuilt backwards from the
  /// balance now, so the transactions are read from the earlier of the
  /// month's first day and this month's.
  Future<TimelineView> call(DateTime month) async {
    final today = dateOnly(clock());
    final first = monthStart(month);
    final from = first.isBefore(monthStart(today)) ? first : monthStart(today);
    final all = await accounts.getAll();
    return const BuildTimeline()(
      today: today,
      month: first,
      balance: all.fold(0.0, (sum, a) => sum + a.balance),
      accountNames: all.namesById,
      rules: await planning(),
      ctx: await schedule(from),
      transactions: await transactions.getBetween(from, addDays(today, 1)),
      cap: await cap.read(),
    );
  }
}
