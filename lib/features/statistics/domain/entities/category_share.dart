import 'package:equatable/equatable.dart';

class CategoryShare extends Equatable {
  const CategoryShare({
    required this.category,
    required this.amount,
    required this.percent,
  });

  final String category;
  final double amount;

  /// 0..100 of the month's expenses.
  final double percent;

  @override
  List<Object?> get props => [category, amount, percent];
}
