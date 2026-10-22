import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/core/utils/group_by.dart';
import 'package:flux_wallet/features/statistics/domain/entities/month_totals.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_debt_x.dart';

/// Income and spending per month (debt movements are neither) for the [count] months ending with [today]'s.
List<MonthTotals> monthTotals(
  List<Transaction> all,
  DateTime today,
  int count,
) {
  final byMonth = groupBy(all, (t) => monthStart(t.date));
  return [
    for (var i = count - 1; i >= 0; i--)
      _totals(DateTime(today.year, today.month - i), byMonth),
  ];
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
