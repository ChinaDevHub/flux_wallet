import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/home/data/repositories/account_repository_impl.dart';
import 'package:flux_wallet/features/home/data/repositories/day_flag_repository_impl.dart';
import 'package:flux_wallet/features/home/data/repositories/recurring_rule_repository_impl.dart';
import 'package:flux_wallet/features/home/data/repositories/transaction_repository_impl.dart';
import 'package:flux_wallet/features/home/domain/usecases/load_home_snapshot.dart';
import 'package:flux_wallet/features/onboarding/data/profile_repository_impl.dart';
import 'package:flux_wallet/features/onboarding/domain/repositories/profile_repository.dart';

/// Composition root: the only place that knows the concrete implementations.
class AppDependencies {
  AppDependencies({AppDatabase? database, this.clock = DateTime.now})
    : database = database ?? AppDatabase() {
    profile = ProfileRepositoryImpl(this.database);
    loadHome = LoadHomeSnapshot(
      profile: profile,
      accounts: AccountRepositoryImpl(this.database),
      transactions: TransactionRepositoryImpl(this.database),
      rules: RecurringRuleRepositoryImpl(this.database),
      dayFlags: DayFlagRepositoryImpl(this.database),
      clock: clock,
    );
  }

  final AppDatabase database;
  final Clock clock;
  late final ProfileRepository profile;
  late final LoadHomeSnapshot loadHome;
}
