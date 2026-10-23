import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/rule_schedule_label.dart';

RecurringRule monthly(int day) => RecurringRule(
  title: 't',
  amount: 1,
  category: 'rent',
  frequency: Frequency.monthly,
  startDate: DateTime(2026, 1, day),
);

void main() {
  test('monthly labels use the right Azerbaijani suffix', () {
    final labels = {
      1: 'Ayın 1-i',
      2: 'Ayın 2-si',
      3: 'Ayın 3-ü',
      6: 'Ayın 6-sı',
      10: 'Ayın 10-u',
      20: 'Ayın 20-si',
      25: 'Ayın 25-i',
      30: 'Ayın 30-u',
    };
    labels.forEach(
      (day, text) => expect(ruleScheduleLabel(monthly(day)), text),
    );
  });

  test('other frequencies and end dates', () {
    final bus = RecurringRule(
      title: 'Avtobus',
      amount: 1,
      category: 'bus',
      frequency: Frequency.weekdays,
      startDate: DateTime(2026, 1, 1),
      endDate: DateTime(2026, 10, 28),
    );
    expect(ruleScheduleLabel(bus), 'İş günləri · 28 Oktyabr tarixinə qədər');
  });

  test('custom days and paused months are spelled out', () {
    final remote = RecurringRule(
      title: 'Avtobus',
      amount: 1,
      category: 'bus',
      frequency: Frequency.weekdays,
      startDate: DateTime(2026, 1, 1),
      weekdays: const {1, 2, 4, 5},
      skipMonths: const {7, 8},
    );
    expect(
      ruleScheduleLabel(remote),
      'İş günləri · Çərşənbə istisna · İyl, Avq ayları istisna',
    );
    final twice = RecurringRule(
      title: 'Hovuz',
      amount: 10,
      category: 'other',
      frequency: Frequency.weekly,
      startDate: DateTime(2026, 10, 7),
      weekdays: const {3, 6},
    );
    expect(ruleScheduleLabel(twice), 'Həftəlik (Çər, Şən)');
  });
}
