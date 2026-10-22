import 'package:flux_wallet/features/notifications/domain/entities/pending_transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

/// The real transaction a confirmed pending item turns into.
Transaction bookedTransaction(
  PendingTransaction p,
  String category,
  int accountId,
) => Transaction(
  amount: p.amount,
  type: p.type,
  category: category,
  accountId: accountId,
  date: p.occurredAt,
  source: TxSource.notification,
  note: p.merchant,
);
