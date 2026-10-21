import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/features/onboarding/data/profile_repository_impl.dart';
import 'package:flux_wallet/features/rules/data/repositories/day_flag_repository_impl.dart';
import 'package:flux_wallet/features/rules/data/repositories/recurring_rule_repository_impl.dart';
import 'package:flux_wallet/features/rules/data/repositories/rule_exception_repository_impl.dart';
import 'package:flux_wallet/features/transactions/data/repositories/account_repository_impl.dart';
import 'package:flux_wallet/features/transactions/data/repositories/transaction_repository_impl.dart';

/// Concrete data-layer implementations, all backed by one [AppDatabase].
class AppRepositories {
  AppRepositories(AppDatabase db)
    : profile = ProfileRepositoryImpl(db),
      accounts = AccountRepositoryImpl(db),
      transactions = TransactionRepositoryImpl(db),
      rules = RecurringRuleRepositoryImpl(db),
      exceptions = RuleExceptionRepositoryImpl(db),
      dayFlags = DayFlagRepositoryImpl(db);

  final ProfileRepositoryImpl profile;
  final AccountRepositoryImpl accounts;
  final TransactionRepositoryImpl transactions;
  final RecurringRuleRepositoryImpl rules;
  final RuleExceptionRepositoryImpl exceptions;
  final DayFlagRepositoryImpl dayFlags;
}
