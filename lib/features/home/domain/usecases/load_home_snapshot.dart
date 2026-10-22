import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';
import 'package:flux_wallet/features/home/domain/usecases/build_home_snapshot.dart';
import 'package:flux_wallet/features/notifications/domain/repositories/pending_repository.dart';
import 'package:flux_wallet/features/auth/domain/repositories/user_repository.dart';
import 'package:flux_wallet/features/debts/domain/usecases/load_planning_rules.dart';
import 'package:flux_wallet/features/rules/domain/usecases/load_schedule_context.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/account_repository.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/transaction_repository.dart';

/// Reads everything from the repositories and delegates to [BuildHomeSnapshot].
class LoadHomeSnapshot {
  const LoadHomeSnapshot({
    required this.users,
    required this.accounts,
    required this.transactions,
    required this.planning,
    required this.schedule,
    required this.pending,
    required this.clock,
  });

  final UserRepository users;
  final AccountRepository accounts;
  final TransactionRepository transactions;
  final LoadPlanningRules planning;
  final LoadScheduleContext schedule;
  final PendingRepository pending;
  final Clock clock;

  Future<HomeSnapshot> call() async {
    final today = dateOnly(clock());
    final all = await accounts.getAll();
    return const BuildHomeSnapshot()(
      userName: (await users.current())?.firstName ?? '',
      today: today,
      balance: all.fold(0.0, (sum, a) => sum + a.balance),
      rules: await planning(),
      ctx: await schedule(today),
      pendingCount: await pending.countPending(),
      todayTx: await transactions.getBetween(today, addDays(today, 1)),
    );
  }
}
