import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/session/session_store.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/auth/data/user_repository_impl.dart';
import 'package:flux_wallet/features/debts/data/debt_repository_impl.dart';
import 'package:flux_wallet/features/notifications/data/merchant_repository_impl.dart';
import 'package:flux_wallet/features/notifications/data/pending_repository_impl.dart';
import 'package:flux_wallet/features/onboarding/data/onboarding_repository_impl.dart';
import 'package:flux_wallet/features/rules/data/repositories/day_flag_repository_impl.dart';
import 'package:flux_wallet/features/rules/data/repositories/recurring_rule_repository_impl.dart';
import 'package:flux_wallet/features/rules/data/repositories/rule_exception_repository_impl.dart';
import 'package:flux_wallet/features/security/data/pin_repository_impl.dart';
import 'package:flux_wallet/features/settings/data/backup_repository_impl.dart';
import 'package:flux_wallet/features/settings/data/settings_repository_impl.dart';
import 'package:flux_wallet/features/transactions/data/repositories/account_repository_impl.dart';
import 'package:flux_wallet/features/transactions/data/repositories/transaction_repository_impl.dart';

/// Concrete repositories on one [AppDatabase], scoped to the signed-in user.
class AppRepositories {
  AppRepositories(AppDatabase db, SessionStore session)
    : this._(db, session, UserScope(session));

  AppRepositories._(AppDatabase db, SessionStore session, UserScope scope)
    : users = UserRepositoryImpl(db, session),
      onboarding = OnboardingRepositoryImpl(db, scope),
      accounts = AccountRepositoryImpl(db, scope),
      transactions = TransactionRepositoryImpl(db, scope),
      rules = RecurringRuleRepositoryImpl(db, scope),
      exceptions = RuleExceptionRepositoryImpl(db, scope),
      dayFlags = DayFlagRepositoryImpl(db, scope),
      pending = PendingRepositoryImpl(db, scope),
      merchants = MerchantRepositoryImpl(db, scope),
      debts = DebtRepositoryImpl(db, scope),
      pins = PinRepositoryImpl(db, scope),
      settings = SettingsRepositoryImpl(db),
      backup = BackupRepositoryImpl(db, scope);

  final UserRepositoryImpl users;
  final OnboardingRepositoryImpl onboarding;
  final AccountRepositoryImpl accounts;
  final TransactionRepositoryImpl transactions;
  final RecurringRuleRepositoryImpl rules;
  final RuleExceptionRepositoryImpl exceptions;
  final DayFlagRepositoryImpl dayFlags;
  final PendingRepositoryImpl pending;
  final MerchantRepositoryImpl merchants;
  final DebtRepositoryImpl debts;
  final PinRepositoryImpl pins;
  final SettingsRepositoryImpl settings;
  final BackupRepositoryImpl backup;
}
