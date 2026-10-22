import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_debt_x.dart';

extension TransactionListX on List<Transaction> {
  double get totalExpense => where(
    (t) => t.type == TxType.expense,
  ).fold(0.0, (sum, t) => sum + t.amount);

  /// Spending the daily limit is about: debt movements are not spending, and
  /// a payment is a planned obligation, so it is neither taken from today's
  /// budget nor added back to it.
  double get discretionaryExpense => where(
    (t) => t.type == TxType.expense && !t.isDebtMovement,
  ).fold(0.0, (sum, t) => sum + t.amount);
}
