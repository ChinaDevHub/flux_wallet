import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/statistics/domain/entities/statistics_view.dart';
import 'package:flux_wallet/features/statistics/domain/entities/stats_range.dart';
import 'package:flux_wallet/features/statistics/domain/usecases/category_shares_builder.dart';
import 'package:flux_wallet/features/statistics/domain/usecases/month_totals_builder.dart';
import 'package:flux_wallet/features/statistics/domain/usecases/slider_months.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/transaction_repository.dart';

class LoadStatistics {
  const LoadStatistics(this._transactions, this._clock);

  static const defaultPreset = StatsPreset.six;

  final TransactionRepository _transactions;
  final Clock _clock;

  /// [range] defaults to the last six months; [month] (one of its months)
  /// narrows the category breakdown and the summary to that month.
  Future<StatisticsView> call({StatsRange? range, DateTime? month}) async {
    final today = dateOnly(_clock());
    final r = range ?? StatsRange.last(defaultPreset.months, today);
    final pick = month != null && r.contains(month) ? monthStart(month) : null;
    final end = DateTime(r.to.year, r.to.month + 1);
    final all = await _transactions.getBetween(r.from, end);
    return StatisticsView(
      range: r,
      preset: r.presetAt(today),
      available: sliderMonths(await _transactions.earliestDate(), today),
      months: monthTotals(all, r),
      selected: pick,
      shares: categoryShares(all, pick == null ? r : StatsRange(pick, pick)),
    );
  }
}
