import 'package:flux_wallet/features/home/domain/entities/transaction.dart';

abstract interface class TransactionRepository {
  /// Transactions with `from <= date < to`, newest first.
  Future<List<Transaction>> getBetween(DateTime from, DateTime to);

  /// Inserts the transaction and adjusts the account balance atomically.
  Future<int> add(Transaction transaction);
}
