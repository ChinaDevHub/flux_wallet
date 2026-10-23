import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:sqflite/sqflite.dart';

const _open = 'rule_id = ? AND to_date IS NULL';

/// Switches a rule off or on from [day], inside the caller's [txn].
Future<void> writeEnabled(
  DatabaseExecutor txn,
  UserScope scope,
  int id, {
  required bool enabled,
  required DateTime day,
}) async {
  final today = dayKey(day);
  final pause = await txn.query(
    Tables.rulePauses,
    where: scope.where(_open),
    whereArgs: scope.args([id]),
  );
  if (!enabled && pause.isEmpty) {
    await txn.insert(
      Tables.rulePauses,
      scope.stamp({'rule_id': id, 'from_date': today}),
    );
  } else if (enabled && pause.isNotEmpty) {
    final from = pause.first['from_date'] as String;
    final ref = scope.where('id = ?');
    final args = scope.args([pause.first['id']]);
    // Off and on again within one day: it never really stopped.
    if (from.compareTo(today) >= 0) {
      await txn.delete(Tables.rulePauses, where: ref, whereArgs: args);
    } else {
      final last = dayKey(addDays(day, -1));
      await txn.update(
        Tables.rulePauses,
        {'to_date': last},
        where: ref,
        whereArgs: args,
      );
    }
  }
  await txn.update(
    Tables.recurringRules,
    {'is_active': enabled ? 1 : 0},
    where: scope.where('id = ?'),
    whereArgs: scope.args([id]),
  );
}
