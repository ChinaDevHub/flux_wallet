import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

abstract interface class TransactionRepository {
  /// Transactions with `from <= date < to`, newest first.
  Future<List<Transaction>> getBetween(DateTime from, DateTime to);

  /// The date of the oldest transaction, or null when there is none.
  Future<DateTime?> earliestDate();

  /// Inserts the transaction and adjusts the account balance atomically.
  Future<int> add(Transaction transaction);

  /// Replaces the stored transaction with the same id and re-balances the
  /// accounts. Throws `StateError` for money that belongs to a debt.
  Future<void> update(Transaction transaction);

  /// Removes the transaction and takes its money back off the balance.
  /// Throws `StateError` for money that belongs to a debt.
  Future<void> delete(int id);
}
