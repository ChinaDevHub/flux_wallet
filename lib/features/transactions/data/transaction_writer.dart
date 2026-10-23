import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/transactions/data/mappers/transaction_mapper.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;

/// Moves an account's balance by [delta], inside the caller's [txn].
Future<void> moveBalance(
  DatabaseExecutor txn,
  UserScope scope,
  int accountId,
  double delta,
) => txn.rawUpdate(
  'UPDATE ${Tables.accounts} SET balance = balance + ? '
  'WHERE ${scope.where('id = ?')}',
  scope.args([delta, accountId]),
);

/// Inserts [t] and moves the account balance, inside the caller's [txn].
Future<int> insertTransaction(
  DatabaseExecutor txn,
  UserScope scope,
  Transaction t,
) async {
  await moveBalance(txn, scope, t.accountId, t.signedAmount);
  return txn.insert(Tables.transactions, scope.stamp(t.toMap()..remove('id')));
}
