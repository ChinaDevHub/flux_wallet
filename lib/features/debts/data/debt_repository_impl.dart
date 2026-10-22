import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/debts/data/debt_mapper.dart';
import 'package:flux_wallet/features/debts/data/debt_sql.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_payment.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/debts/domain/repositories/debt_repository.dart';
import 'package:flux_wallet/features/transactions/data/transaction_writer.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

class DebtRepositoryImpl implements DebtRepository {
  const DebtRepositoryImpl(this._db, this._scope);

  final AppDatabase _db;
  final UserScope _scope;

  @override
  Future<List<DebtSummary>> getAll() async {
    final db = await _db.instance;
    final rows = await db.rawQuery(selectDebtSummaries, [_scope.id]);
    return rows.map(debtSummaryFromMap).toList();
  }

  @override
  Future<int> add(Debt debt) =>
      _db.write((db) => db.insert(Tables.debts, _scope.stamp(debt.toMap())));

  @override
  Future<void> delete(int id) => _db.write(
    (db) => db.delete(
      Tables.debts,
      where: _scope.where('id = ?'),
      whereArgs: _scope.args([id]),
    ),
  );

  @override
  Future<void> recordPayment(DebtPayment payment, Transaction transaction) =>
      _db.write(
        (db) => db.transaction((txn) async {
          await txn.insert(Tables.debtPayments, _scope.stamp(payment.toMap()));
          await insertTransaction(txn, _scope, transaction);
          final id = payment.debtId;
          await txn.rawUpdate(closeIfSettled, [id, _scope.id, id]);
        }),
      );
}
