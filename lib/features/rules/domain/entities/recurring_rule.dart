import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

/// A one-off mandatory payment is a monthly rule with endDate == startDate.
enum Frequency { daily, weekdays, weekly, monthly }

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
    this.weekdays,
    this.skipMonths = const {},
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

  /// Weekdays (DateTime.monday..sunday) a day-based rule happens on; null
  /// means the frequency's usual days (see `activeWeekdays`).
  final Set<int>? weekdays;

  /// Months (1..12) the rule pauses in, e.g. no bus fare in August.
  final Set<int> skipMonths;

  bool get isIncome => type == TxType.income;

  @override
  List<Object?> get props => [
    id, title, amount, category, frequency, startDate, endDate, //
    isActive, type, weekdays, skipMonths,
  ];
}
