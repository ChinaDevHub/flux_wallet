import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/debts/data/debt_mapper.dart';
import 'package:flux_wallet/features/debts/data/debt_sql.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_payment.dart';
import 'package:flux_wallet/features/transactions/data/transaction_writer.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_debt_x.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;

/// The debt and its opening money movement, linked, in the caller's [txn].
Future<int> insertDebt(
  DatabaseExecutor txn,
  UserScope scope,
  Debt debt,
  Transaction opening,
) async {
  final id = await txn.insert(Tables.debts, scope.stamp(debt.toMap()));
  await insertTransaction(txn, scope, opening.forDebt(id));
  return id;
}

/// Removes the debt and its linked money movements from the balances too.
Future<void> deleteDebt(DatabaseExecutor txn, UserScope scope, int id) async {
  await txn.rawUpdate(reverseDebtBalances, [id, scope.id, scope.id]);
  await txn.delete(
    Tables.transactions,
    where: scope.where('debt_id = ?'),
    whereArgs: scope.args([id]),
  );
  await txn.delete(
    Tables.debts,
    where: scope.where('id = ?'),
    whereArgs: scope.args([id]),
  );
}

/// A payment, its linked money movement, and closing the debt if settled.
Future<void> insertDebtPayment(
  DatabaseExecutor txn,
  UserScope scope,
  DebtPayment payment,
  Transaction transaction,
) async {
  await txn.insert(Tables.debtPayments, scope.stamp(payment.toMap()));
  await insertTransaction(txn, scope, transaction.forDebt(payment.debtId));
  final id = payment.debtId;
  await txn.rawUpdate(closeIfSettled, [id, scope.id, id]);
}
