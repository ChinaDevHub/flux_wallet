import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

extension TransactionListX on List<Transaction> {
  double get totalExpense => where(
    (t) => t.type == TxType.expense,
  ).fold(0.0, (sum, t) => sum + t.amount);

  /// Spending the daily limit is about: debt payments are planned obligations
  /// and so are neither taken from today's budget nor added back to it.
  double get discretionaryExpense => where(
    (t) => t.type == TxType.expense && t.category != 'debt',
  ).fold(0.0, (sum, t) => sum + t.amount);
}
