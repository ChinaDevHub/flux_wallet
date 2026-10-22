import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

extension TransactionDebtX on Transaction {
  /// Lending, borrowing and paying back move money without being spending
  /// or earning, so statistics and the daily limit leave them out.
  bool get isDebtMovement => category == 'debt' || category == 'repayment';

  Transaction forDebt(int id) => Transaction(
    id: this.id,
    amount: amount,
    type: type,
    category: category,
    accountId: accountId,
    date: date,
    source: source,
    note: note,
    debtId: id,
  );
}
