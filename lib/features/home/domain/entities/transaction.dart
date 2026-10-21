import 'package:equatable/equatable.dart';

enum TxType { expense, income }

enum TxSource { manual, notification }

/// [amount] is always positive; [type] decides the direction.
class Transaction extends Equatable {
  const Transaction({
    this.id,
    required this.amount,
    required this.type,
    required this.category,
    required this.accountId,
    required this.date,
    this.source = TxSource.manual,
    this.note,
  });

  final int? id;
  final double amount;
  final TxType type;
  final String category;
  final int accountId;
  final DateTime date;
  final TxSource source;
  final String? note;

  double get signedAmount => type == TxType.expense ? -amount : amount;

  @override
  List<Object?> get props => [
    id,
    amount,
    type,
    category,
    accountId,
    date,
    source,
    note,
  ];
}

extension TransactionListX on List<Transaction> {
  double get totalExpense => where(
    (t) => t.type == TxType.expense,
  ).fold(0.0, (sum, t) => sum + t.amount);
}
