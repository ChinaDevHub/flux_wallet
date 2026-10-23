import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/debts/data/debt_details_writer.dart';
import 'package:flux_wallet/features/debts/data/debt_mapper.dart';
import 'package:flux_wallet/features/debts/data/debt_sql.dart';
import 'package:flux_wallet/features/debts/data/debt_writer.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_payment.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/debts/domain/repositories/debt_repository.dart';
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
  Future<int> add(Debt debt, Transaction opening) => _db.write(
    (db) => db.transaction((txn) => insertDebt(txn, _scope, debt, opening)),
  );

  @override
  Future<void> updateDetails(Debt debt) => _db.write(
    (db) => db.transaction((txn) => writeDebtDetails(txn, _scope, debt)),
  );

  @override
  Future<void> delete(int id) =>
      _db.write((db) => db.transaction((txn) => deleteDebt(txn, _scope, id)));

  @override
  Future<void> recordPayment(DebtPayment payment, Transaction transaction) =>
      _db.write(
        (db) => db.transaction(
          (txn) => insertDebtPayment(txn, _scope, payment, transaction),
        ),
      );
}
