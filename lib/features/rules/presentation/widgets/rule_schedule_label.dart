import 'package:flux_wallet/core/utils/az_calendar.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

/// "Ayın 25-i", "İş günləri", ... (+ end date when the rule has one).
String ruleScheduleLabel(RecurringRule rule) {
  final base = switch (rule.frequency) {
    Frequency.daily => 'Hər gün',
    Frequency.weekdays => 'İş günləri',
    Frequency.weekly => 'Həftəlik (${azWeekdays[rule.startDate.weekday - 1]})',
    Frequency.monthly => 'Ayın ${_dayOrdinal(rule.startDate.day)}',
  };
  final end = rule.endDate;
  return end == null ? base : '$base · ${azDayMonth(end)} tarixinə qədər';
}

/// Azerbaijani possessive suffix depends on how the number is pronounced.
String _dayOrdinal(int day) {
  const byDigit = {
    1: 'i',
    2: 'si',
    3: 'ü',
    4: 'ü',
    5: 'i',
    6: 'sı',
    7: 'si',
    8: 'i',
    9: 'u',
  };
  const round = {10: 'u', 20: 'si', 30: 'u'};
  return '$day-${round[day] ?? byDigit[day % 10]}';
}
