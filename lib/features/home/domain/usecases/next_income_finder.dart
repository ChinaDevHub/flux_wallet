import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/home/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/home/domain/usecases/recurrence_expander.dart';

class NextIncomeFinder {
  const NextIncomeFinder([this._expander = const RecurrenceExpander()]);

  final RecurrenceExpander _expander;

  /// Earliest income occurrence strictly after [today], or null.
  DateTime? call(List<RecurringRule> rules, DateTime today) {
    final from = addDays(today, 1);
    final horizon = addDays(today, 400);
    DateTime? next;
    for (final rule in rules.where((r) => r.isIncome)) {
      final dates = _expander.expand(rule, from, horizon);
      if (dates.isEmpty) continue;
      if (next == null || dates.first.isBefore(next)) next = dates.first;
    }
    return next;
  }
}
