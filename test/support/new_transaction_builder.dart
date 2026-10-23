import 'package:flux_wallet/features/transactions/domain/entities/new_transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_kind.dart';

abstract final class NewTransactionBuilder {
  /// "Qızla görüş 50 ₼" on a later day.
  static NewTransaction plan(DateTime day, double amount) => NewTransaction(
    kind: TransactionKind.expense,
    amount: amount,
    category: 'cafe',
    accountId: 1,
    date: day,
    title: 'Görüş',
  );
}
