import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';
import 'package:flux_wallet/features/home/domain/usecases/build_home_snapshot.dart';
import 'package:flux_wallet/features/onboarding/domain/repositories/profile_repository.dart';
import 'package:flux_wallet/features/rules/domain/repositories/recurring_rule_repository.dart';
import 'package:flux_wallet/features/rules/domain/usecases/load_schedule_context.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/account_repository.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/transaction_repository.dart';

/// Reads everything from the repositories and delegates to [BuildHomeSnapshot].
class LoadHomeSnapshot {
  const LoadHomeSnapshot({
    required this.profile,
    required this.accounts,
    required this.transactions,
    required this.rules,
    required this.schedule,
    required this.clock,
  });

  final ProfileRepository profile;
  final AccountRepository accounts;
  final TransactionRepository transactions;
  final RecurringRuleRepository rules;
  final LoadScheduleContext schedule;
  final Clock clock;

  Future<HomeSnapshot> call() async {
    final today = dateOnly(clock());
    final all = await accounts.getAll();
    return const BuildHomeSnapshot()(
      userName: await profile.readName() ?? '',
      today: today,
      balance: all.fold(0.0, (sum, a) => sum + a.balance),
      rules: await rules.getActive(),
      ctx: await schedule(today),
      todayTx: await transactions.getBetween(today, addDays(today, 1)),
    );
  }
}
