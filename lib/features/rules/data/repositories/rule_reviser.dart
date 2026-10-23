import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/data/mappers/recurring_rule_mapper.dart';
import 'package:flux_wallet/features/rules/data/repositories/rule_pause_writer.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:sqflite/sqflite.dart';

/// [old] ends the day before [from]; [next] starts there. Skips that lie
/// ahead move to [next], and so does a switched-off state. Inside [txn].
Future<int> reviseRule(
  DatabaseExecutor txn,
  UserScope scope,
  RecurringRule old,
  RecurringRule next,
  DateTime from,
) async {
  final last = addDays(dateOnly(from), -1);
  final oldEnd = old.endDate;
  final keepEnd = oldEnd != null && dateOnly(oldEnd).isBefore(last);
  await txn.update(
    Tables.recurringRules,
    {'end_date': dayKey(keepEnd ? oldEnd : last)},
    where: scope.where('id = ?'),
    whereArgs: scope.args([old.id]),
  );
  final row = next.toMap()..remove('id');
  final id = await txn.insert(Tables.recurringRules, scope.stamp(row));
  await txn.update(
    Tables.ruleExceptions,
    {'rule_id': id},
    where: scope.where('rule_id = ? AND date >= ?'),
    whereArgs: scope.args([old.id, dayKey(from)]),
  );
  if (!next.isActive) {
    await writeEnabled(txn, scope, id, enabled: false, day: from);
  }
  return id;
}
