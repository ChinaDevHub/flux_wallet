import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

extension TransactionMapper on Transaction {
  Map<String, Object?> toMap() => {
    'id': id,
    'amount': amount,
    'type': type.name,
    'category': category,
    'account_id': accountId,
    'date': date.toIso8601String(),
    'source': source.name,
    'note': note,
  };
}

Transaction transactionFromMap(Map<String, Object?> m) => Transaction(
  id: m['id'] as int,
  amount: (m['amount'] as num).toDouble(),
  type: TxType.values.byName(m['type'] as String),
  category: m['category'] as String,
  accountId: m['account_id'] as int,
  date: DateTime.parse(m['date'] as String),
  source: TxSource.values.byName(m['source'] as String),
  note: m['note'] as String?,
);
