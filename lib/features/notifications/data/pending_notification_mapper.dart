import 'package:flux_wallet/features/notifications/domain/entities/pending_transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

extension PendingNotificationMapper on PendingTransaction {
  Map<String, Object?> toMap() => {
    'fingerprint': fingerprint,
    'raw_text': rawText,
    'merchant': merchant,
    'amount': amount,
    'type': type.name,
    'occurred_at': occurredAt.toIso8601String(),
    'category': category,
    'status': status.name,
  };
}

PendingTransaction pendingFromMap(Map<String, Object?> m) => PendingTransaction(
  id: m['id'] as int,
  fingerprint: m['fingerprint'] as String,
  rawText: m['raw_text'] as String,
  merchant: m['merchant'] as String,
  amount: (m['amount'] as num).toDouble(),
  type: TxType.values.byName(m['type'] as String),
  occurredAt: DateTime.parse(m['occurred_at'] as String),
  category: m['category'] as String?,
  status: PendingStatus.values.byName(m['status'] as String),
);
