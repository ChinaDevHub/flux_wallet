import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/transactions/data/mappers/transaction_mapper.dart';
import 'package:flux_wallet/features/transactions/data/transaction_writer.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  const TransactionRepositoryImpl(this._db, this._scope);

  final AppDatabase _db;
  final UserScope _scope;

  @override
  Future<List<Transaction>> getBetween(DateTime from, DateTime to) async {
    final db = await _db.instance;
    final rows = await db.query(
      Tables.transactions,
      where: _scope.where('date >= ? AND date < ?'),
      whereArgs: _scope.args([from.toIso8601String(), to.toIso8601String()]),
      orderBy: 'date DESC',
    );
    return rows.map(transactionFromMap).toList();
  }

  @override
  Future<int> add(Transaction t) => _db.write(
    (db) => db.transaction((txn) => insertTransaction(txn, _scope, t)),
  );
}
