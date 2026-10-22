import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/statistics/domain/entities/category_share.dart';
import 'package:flux_wallet/features/statistics/domain/entities/month_totals.dart';

class StatisticsView extends Equatable {
  const StatisticsView({
    required this.months,
    required this.selected,
    required this.shares,
  });

  /// Oldest first, ending with the current month.
  final List<MonthTotals> months;

  /// First day of the month the category breakdown is for.
  final DateTime selected;
  final List<CategoryShare> shares;

  MonthTotals get selectedTotals =>
      months.firstWhere((m) => m.month == selected, orElse: () => months.last);

  @override
  List<Object?> get props => [months, selected, shares];
}
