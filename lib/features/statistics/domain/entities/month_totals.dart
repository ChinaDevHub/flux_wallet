import 'package:equatable/equatable.dart';

class MonthTotals extends Equatable {
  const MonthTotals({
    required this.month,
    required this.income,
    required this.expense,
  });

  /// First day of the month.
  final DateTime month;
  final double income, expense;

  double get net => income - expense;

  @override
  List<Object?> get props => [month, income, expense];
}
