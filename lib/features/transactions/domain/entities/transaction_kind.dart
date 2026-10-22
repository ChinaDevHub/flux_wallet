import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

/// What the user picks on the "Yeni əməliyyat" screen. Debts are not here:
/// they live on the Borclar tab, where they keep their own record.
enum TransactionKind {
  expense('Xərc', TxType.expense),
  income('Gəlir', TxType.income);

  const TransactionKind(this.label, this.type);

  final String label;
  final TxType type;
}
