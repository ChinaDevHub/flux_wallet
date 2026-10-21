import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

/// What the user picks on the "Yeni əməliyyat" screen. Debt and repayment are
/// stored as an expense / income with a fixed category.
enum TransactionKind {
  expense('Xərc', TxType.expense, null),
  income('Gəlir', TxType.income, null),
  debt('Borc', TxType.expense, 'debt'),
  repayment('Qaytarma', TxType.income, 'repayment');

  const TransactionKind(this.label, this.type, this.fixedCategory);

  final String label;
  final TxType type;

  /// Null when the user chooses the category from the grid.
  final String? fixedCategory;

  bool get isPerson => fixedCategory != null;
}
