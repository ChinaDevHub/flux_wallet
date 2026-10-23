import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/transactions/data/mappers/transaction_mapper.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;

/// The stored transaction [id] of the signed-in user. A money movement that
/// belongs to a debt is changed from the debt, never on its own.
Future<Transaction> loadEditable(
  DatabaseExecutor txn,
  UserScope scope,
  int id,
) async {
  final rows = await txn.query(
    Tables.transactions,
    where: scope.where('id = ?'),
    whereArgs: scope.args([id]),
  );
  if (rows.isEmpty) throw StateError('No such transaction');
  final t = transactionFromMap(rows.first);
  if (t.debtId != null) throw StateError('Part of a debt');
  return t;
}
