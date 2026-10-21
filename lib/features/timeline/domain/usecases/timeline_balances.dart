import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/planned_payment.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

double _plannedNet(List<PlannedPayment> plans) => plans.fold(
  0.0,
  (sum, p) => sum + (p.rule.isIncome ? p.rule.amount : -p.rule.amount),
);

/// Balance at the end of every day of [month].
///
/// Before today the history is rebuilt by undoing transactions backwards from
/// the current [balance]; from today on the planned items are applied forwards.
Map<DateTime, double> endBalances({
  required DateTime month,
  required DateTime today,
  required double balance,
  required Map<DateTime, List<Transaction>> transactions,
  required Map<DateTime, List<PlannedPayment>> plans,
}) {
  final first = monthStart(month);
  final last = monthEnd(month);
  final ends = <DateTime, double>{};
  var running = balance;
  for (var d = today; d.isAfter(first); d = addDays(d, -1)) {
    for (final t in transactions[d] ?? const <Transaction>[]) {
      running -= t.signedAmount;
    }
    ends[addDays(d, -1)] = running;
  }
  running = balance;
  for (var d = today; !d.isAfter(last); d = addDays(d, 1)) {
    running += _plannedNet(plans[d] ?? const []);
    ends[d] = running;
  }
  return ends;
}
