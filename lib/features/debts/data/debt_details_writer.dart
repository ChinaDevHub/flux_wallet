import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:sqflite/sqflite.dart';

/// New person / due date / note, also on the debt's money movements.
Future<void> writeDebtDetails(
  DatabaseExecutor txn,
  UserScope scope,
  Debt debt,
) async {
  await txn.update(
    Tables.debts,
    {
      'person': debt.person,
      'due_date': debt.dueDate == null ? null : dayKey(debt.dueDate!),
      'note': debt.note,
    },
    where: scope.where('id = ?'),
    whereArgs: scope.args([debt.id]),
  );
  await txn.update(
    Tables.transactions,
    {'note': debt.person},
    where: scope.where('debt_id = ?'),
    whereArgs: scope.args([debt.id]),
  );
}
