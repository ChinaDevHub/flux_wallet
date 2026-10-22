import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/statistics/domain/entities/statistics_view.dart';
import 'package:flux_wallet/features/statistics/domain/usecases/category_shares_builder.dart';
import 'package:flux_wallet/features/statistics/domain/usecases/month_totals_builder.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/transaction_repository.dart';

class LoadStatistics {
  const LoadStatistics(this._transactions, this._clock);

  static const monthsShown = 6;

  final TransactionRepository _transactions;
  final Clock _clock;

  /// [selected] is the month (any day in it) the breakdown is shown for.
  Future<StatisticsView> call([DateTime? selected]) async {
    final today = dateOnly(_clock());
    final from = DateTime(today.year, today.month - (monthsShown - 1));
    final all = await _transactions.getBetween(from, addDays(today, 1));
    final month = monthStart(selected ?? today);
    return StatisticsView(
      months: monthTotals(all, today, monthsShown),
      selected: month,
      shares: categoryShares(all, month),
    );
  }
}
