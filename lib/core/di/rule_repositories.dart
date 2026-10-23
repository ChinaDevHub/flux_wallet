import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/rules/data/repositories/day_flag_repository_impl.dart';
import 'package:flux_wallet/features/rules/data/repositories/recurring_rule_repository_impl.dart';
import 'package:flux_wallet/features/rules/data/repositories/rule_exception_repository_impl.dart';
import 'package:flux_wallet/features/rules/data/repositories/rule_pause_repository_impl.dart';

/// The repositories behind recurring rules and how they play out.
abstract class RuleRepositories {
  RuleRepositories(AppDatabase db, UserScope scope)
    : rules = RecurringRuleRepositoryImpl(db, scope),
      exceptions = RuleExceptionRepositoryImpl(db, scope),
      pauses = RulePauseRepositoryImpl(db, scope),
      dayFlags = DayFlagRepositoryImpl(db, scope);

  final RecurringRuleRepositoryImpl rules;
  final RuleExceptionRepositoryImpl exceptions;
  final RulePauseRepositoryImpl pauses;
  final DayFlagRepositoryImpl dayFlags;
}
