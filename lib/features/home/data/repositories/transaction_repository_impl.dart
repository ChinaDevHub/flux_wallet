import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/features/home/data/mappers/transaction_mapper.dart';
import 'package:flux_wallet/features/home/domain/entities/transaction.dart';
import 'package:flux_wallet/features/home/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  const TransactionRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<List<Transaction>> getBetween(DateTime from, DateTime to) async {
    final db = await _db.instance;
    final rows = await db.query(
      Tables.transactions,
      where: 'date >= ? AND date < ?',
      whereArgs: [from.toIso8601String(), to.toIso8601String()],
      orderBy: 'date DESC',
    );
    return rows.map(transactionFromMap).toList();
  }

  @override
  Future<int> add(Transaction t) async {
    final db = await _db.instance;
    return db.transaction((txn) async {
      await txn.rawUpdate(
        'UPDATE ${Tables.accounts} SET balance = balance + ? WHERE id = ?',
        [t.signedAmount, t.accountId],
      );
      return txn.insert(Tables.transactions, t.toMap()..remove('id'));
    });
  }
}
