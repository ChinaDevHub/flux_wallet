import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/statistics/domain/entities/category_share.dart';
import 'package:flux_wallet/features/statistics/domain/entities/month_totals.dart';
import 'package:flux_wallet/features/statistics/domain/entities/stats_range.dart';

class StatisticsView extends Equatable {
  const StatisticsView({
    required this.range,
    required this.available,
    required this.months,
    required this.shares,
    this.selected,
    this.preset,
  });

  final StatsRange range;

  /// The ready-made period the range is (last N months), if it is one.
  final StatsPreset? preset;

  /// Every month the range can be moved over, oldest first.
  final List<DateTime> available;

  /// The range's months, oldest first.
  final List<MonthTotals> months;

  /// The one month picked in the chart; null means the whole range.
  final DateTime? selected;

  /// Spending by category in [selected], or in the whole range.
  final List<CategoryShare> shares;

  MonthTotals get selectedTotals {
    final pick = selected;
    if (pick != null) return months.firstWhere((m) => m.month == pick);
    return MonthTotals(
      month: range.from,
      income: months.fold(0.0, (s, m) => s + m.income),
      expense: months.fold(0.0, (s, m) => s + m.expense),
    );
  }

  @override
  List<Object?> get props => [
    range, available, months, selected, shares, preset, //
  ];
}
