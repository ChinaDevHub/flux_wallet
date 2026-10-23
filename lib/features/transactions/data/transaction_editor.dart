import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/transactions/data/mappers/transaction_mapper.dart';
import 'package:flux_wallet/features/transactions/data/transaction_load.dart';
import 'package:flux_wallet/features/transactions/data/transaction_writer.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;

/// Takes the transaction out and its money back off the balance.
Future<void> removeTransaction(
  DatabaseExecutor txn,
  UserScope scope,
  int id,
) async {
  final old = await loadEditable(txn, scope, id);
  await moveBalance(txn, scope, old.accountId, -old.signedAmount);
  await txn.delete(
    Tables.transactions,
    where: scope.where('id = ?'),
    whereArgs: scope.args([id]),
  );
}

/// Replaces the stored transaction: the old money comes off its account, the
/// new money goes onto its (maybe different) account.
Future<void> replaceTransaction(
  DatabaseExecutor txn,
  UserScope scope,
  Transaction t,
) async {
  final old = await loadEditable(txn, scope, t.id!);
  await moveBalance(txn, scope, old.accountId, -old.signedAmount);
  await moveBalance(txn, scope, t.accountId, t.signedAmount);
  await txn.update(
    Tables.transactions,
    t.toMap()..remove('id'),
    where: scope.where('id = ?'),
    whereArgs: scope.args([t.id]),
  );
}
