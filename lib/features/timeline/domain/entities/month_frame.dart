import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/planned_payment.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

/// Everything one month of the calendar is built from.
class MonthFrame {
  const MonthFrame({
    required this.month,
    required this.today,
    required this.balance,
    required this.rules,
    required this.ctx,
    required this.transactions,
    required this.plans,
    this.accountNames = const {},
    this.cap,
  });

  /// First day of the month on show.
  final DateTime month;
  final DateTime today;

  /// The balance right now.
  final double balance;
  final List<RecurringRule> rules;
  final ScheduleContext ctx;

  /// Real transactions and planned items, by day.
  final Map<DateTime, List<Transaction>> transactions;
  final Map<DateTime, List<PlannedPayment>> plans;
  final Map<int, String> accountNames;

  /// The user's own daily cap, if set.
  final double? cap;

  DateTime get first => monthStart(month);
  DateTime get last => monthEnd(month);

  List<Transaction> transactionsOn(DateTime d) => transactions[d] ?? const [];
  List<PlannedPayment> plansOn(DateTime d) => plans[d] ?? const [];

  /// Every day of the month, first to last.
  Iterable<DateTime> get days sync* {
    for (var d = first; !d.isAfter(last); d = addDays(d, 1)) {
      yield d;
    }
  }
}
