import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/core/utils/group_by.dart';
import 'package:flux_wallet/features/statistics/domain/entities/month_totals.dart';
import 'package:flux_wallet/features/statistics/domain/entities/stats_range.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_debt_x.dart';

/// Income and spending per month of [range] (debt movements are neither).
List<MonthTotals> monthTotals(List<Transaction> all, StatsRange range) {
  final byMonth = groupBy(all, (t) => monthStart(t.date));
  return [for (final m in range.months) _totals(m, byMonth)];
}

MonthTotals _totals(DateTime month, Map<DateTime, List<Transaction>> byMonth) {
  final items = (byMonth[month] ?? const <Transaction>[])
      .where((t) => !t.isDebtMovement)
      .toList();
  double sum(TxType type) =>
      items.where((t) => t.type == type).fold(0.0, (s, t) => s + t.amount);
  return MonthTotals(
    month: month,
    income: sum(TxType.income),
    expense: sum(TxType.expense),
  );
}
