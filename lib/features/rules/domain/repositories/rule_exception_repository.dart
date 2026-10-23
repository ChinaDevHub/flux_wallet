import 'package:flux_wallet/features/rules/domain/entities/rule_exception.dart';

abstract interface class RuleExceptionRepository {
  /// ruleId -> skipped dates on or after [from].
  Future<Map<int, Set<DateTime>>> getFrom(DateTime from);
  Future<void> add(RuleException exception);

  /// Brings a skipped occurrence back.
  Future<void> remove(RuleException exception);
}
