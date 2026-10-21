import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/home/domain/entities/transaction.dart';

/// A one-off mandatory payment is a monthly rule with endDate == startDate.
enum Frequency { daily, weekdays, monthly }

class RecurringRule extends Equatable {
  const RecurringRule({
    this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.frequency,
    required this.startDate,
    this.endDate,
    this.isActive = true,
    this.type = TxType.expense,
  });

  final int? id;
  final String title;
  final double amount;
  final String category;
  final Frequency frequency;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final TxType type;

  bool get isIncome => type == TxType.income;

  @override
  List<Object?> get props => [
    id,
    title,
    amount,
    category,
    frequency,
    startDate,
    endDate,
    isActive,
    type,
  ];
}
