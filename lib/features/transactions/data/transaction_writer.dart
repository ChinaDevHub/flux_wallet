import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/transactions/data/mappers/transaction_mapper.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;

/// Inserts [t] and moves the account balance, inside the caller's [txn].
Future<int> insertTransaction(
  DatabaseExecutor txn,
  UserScope scope,
  Transaction t,
) async {
  await txn.rawUpdate(
    'UPDATE ${Tables.accounts} SET balance = balance + ? WHERE ${scope.where('id = ?')}',
    scope.args([t.signedAmount, t.accountId]),
  );
  return txn.insert(Tables.transactions, scope.stamp(t.toMap()..remove('id')));
}
