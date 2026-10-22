import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

RecurringRule _rule(
  String title,
  double amount,
  String category,
  Frequency f,
  DateTime start,
) => RecurringRule(
  title: title,
  amount: amount,
  category: category,
  frequency: f,
  startDate: start,
);

List<RecurringRule> demoRules(DateTime today) => [
  _rule('Avtobus', 1, 'bus', Frequency.weekdays, addDays(today, -30)),
  _rule('Kirayə', 250, 'rent', Frequency.monthly, addDays(today, 5)),
];
