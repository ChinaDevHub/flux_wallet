import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/planned_payment.dart';
import 'package:flux_wallet/features/timeline/domain/entities/month_frame.dart';

double _plannedNet(List<PlannedPayment> plans) => plans.fold(
  0.0,
  (sum, p) => sum + (p.rule.isIncome ? p.rule.amount : -p.rule.amount),
);

/// Balance at the end of every day of the month.
///
/// Before today the history is rebuilt by undoing transactions backwards from
/// the balance now; from today on the planned items are applied forwards.
Map<DateTime, double> endBalances(MonthFrame f) {
  final ends = <DateTime, double>{};
  var running = f.balance;
  for (var d = f.today; d.isAfter(f.first); d = addDays(d, -1)) {
    for (final t in f.transactionsOn(d)) {
      running -= t.signedAmount;
    }
    ends[addDays(d, -1)] = running;
  }
  running = f.balance;
  for (var d = f.today; !d.isAfter(f.last); d = addDays(d, 1)) {
    running += _plannedNet(f.plansOn(d));
    ends[d] = running;
  }
  return ends;
}
