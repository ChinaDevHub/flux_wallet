import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';
import 'package:flux_wallet/features/home/domain/repositories/account_repository.dart';
import 'package:flux_wallet/features/home/domain/repositories/day_flag_repository.dart';
import 'package:flux_wallet/features/home/domain/repositories/recurring_rule_repository.dart';
import 'package:flux_wallet/features/home/domain/repositories/transaction_repository.dart';
import 'package:flux_wallet/features/home/domain/usecases/build_home_snapshot.dart';
import 'package:flux_wallet/features/onboarding/domain/repositories/profile_repository.dart';

/// Reads everything from the repositories and delegates to [BuildHomeSnapshot].
class LoadHomeSnapshot {
  const LoadHomeSnapshot({
    required this.profile,
    required this.accounts,
    required this.transactions,
    required this.rules,
    required this.dayFlags,
    required this.clock,
  });

  final ProfileRepository profile;
  final AccountRepository accounts;
  final TransactionRepository transactions;
  final RecurringRuleRepository rules;
  final DayFlagRepository dayFlags;
  final Clock clock;

  Future<HomeSnapshot> call() async {
    final today = dateOnly(clock());
    final all = await accounts.getAll();
    return const BuildHomeSnapshot()(
      userName: await profile.readName() ?? '',
      today: today,
      balance: all.fold(0.0, (sum, a) => sum + a.balance),
      rules: await rules.getActive(),
      offDays: await dayFlags.getOffDaysFrom(today),
      todayTx: await transactions.getBetween(today, addDays(today, 1)),
    );
  }
}
