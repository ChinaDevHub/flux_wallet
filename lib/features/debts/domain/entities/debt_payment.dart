import 'package:equatable/equatable.dart';

/// One (partial) repayment of a debt.
class DebtPayment extends Equatable {
  const DebtPayment({
    this.id,
    required this.debtId,
    required this.amount,
    required this.date,
  });

  final int? id;
  final int debtId;
  final double amount;
  final DateTime date;

  @override
  List<Object?> get props => [id, debtId, amount, date];
}
