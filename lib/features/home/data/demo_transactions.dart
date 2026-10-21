import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

Transaction _expense(
  double amount,
  String category,
  String note,
  DateTime at,
) => Transaction(
  amount: amount,
  type: TxType.expense,
  category: category,
  accountId: 1,
  date: at,
  note: note,
);

List<Transaction> demoTransactions(DateTime now) => [
  _expense(4.8, 'taxi', 'Bolt', now),
  _expense(3.2, 'grocery', 'Bravo Market', now),
];
