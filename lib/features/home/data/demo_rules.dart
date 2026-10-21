import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/home/domain/entities/recurring_rule.dart';

RecurringRule _rule(
  String title,
  double amount,
  String category,
  Frequency f,
  DateTime start, {
  bool once = false,
}) => RecurringRule(
  title: title,
  amount: amount,
  category: category,
  frequency: f,
  startDate: start,
  endDate: once ? start : null,
);

List<RecurringRule> demoRules(DateTime today) => [
  _rule('Avtobus', 1, 'bus', Frequency.weekdays, addDays(today, -30)),
  _rule('Kirayə', 250, 'rent', Frequency.monthly, addDays(today, 5)),
  _rule(
    'Kamal (Borc)',
    50,
    'debt',
    Frequency.monthly,
    addDays(today, 6),
    once: true,
  ),
];
