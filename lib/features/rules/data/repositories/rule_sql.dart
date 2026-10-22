import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/rules/data/mappers/recurring_rule_mapper.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

/// The signed-in user's rules, optionally narrowed by an SQL [where].
Future<List<RecurringRule>> selectRules(
  AppDatabase db,
  UserScope scope, [
  String? where,
]) async {
  final rows = await (await db.instance).query(
    Tables.recurringRules,
    where: scope.where(where),
    whereArgs: scope.args(),
  );
  return rows.map(ruleFromMap).toList();
}
