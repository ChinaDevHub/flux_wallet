import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/rules/data/repositories/rule_pause_writer.dart';
import 'package:flux_wallet/features/rules/data/repositories/rule_reviser.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

/// Switching a rule off / on and splitting it, each in one transaction.
mixin RuleStateWrites {
  AppDatabase get db;
  UserScope get scope;

  Future<void> setEnabled(
    int id, {
    required bool enabled,
    required DateTime day,
  }) => db.write(
    (d) => d.transaction(
      (txn) => writeEnabled(txn, scope, id, enabled: enabled, day: day),
    ),
  );

  Future<void> revise(RecurringRule old, RecurringRule next, DateTime from) =>
      db.write(
        (d) => d.transaction((txn) => reviseRule(txn, scope, old, next, from)),
      );
}
