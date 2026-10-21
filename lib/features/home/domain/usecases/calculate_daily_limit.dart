import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/home/domain/entities/daily_limit.dart';
import 'package:flux_wallet/features/home/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/home/domain/usecases/recurrence_expander.dart';

/// Free money = balance - mandatory expenses until the next income.
/// Daily limit = free money / days until the next income.
class CalculateDailyLimit {
  const CalculateDailyLimit([this._expander = const RecurrenceExpander()]);

  final RecurrenceExpander _expander;

  DailyLimit call({
    required double totalBalance,
    required List<RecurringRule> rules,
    required DateTime today,
    DateTime? nextIncome,
    Set<DateTime> offDays = const {},
  }) {
    final day = dateOnly(today);
    final income = nextIncome ?? DateTime(day.year, day.month + 1);
    final lastDay = addDays(income, -1);
    var obligations = 0.0;
    for (final rule in rules.where((r) => !r.isIncome)) {
      final hits = _expander.expand(rule, day, lastDay, offDays: offDays);
      obligations += hits.length * rule.amount;
    }
    return DailyLimit(
      totalBalance: totalBalance,
      obligations: obligations,
      daysLeft: daysBetween(day, income),
      nextIncome: income,
    );
  }

  /// Per-day spendable amount; never negative, rounded down to qəpik.
  double perDay(DailyLimit limit) =>
      limit.hasShortfall ? 0 : floorCents(limit.freeMoney / limit.daysLeft);
}
