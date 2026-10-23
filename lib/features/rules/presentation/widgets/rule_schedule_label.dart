import 'package:flux_wallet/core/utils/az_calendar.dart';
import 'package:flux_wallet/core/utils/az_names.dart';
import 'package:flux_wallet/core/utils/az_ordinal.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule_live.dart';
import 'package:flux_wallet/features/rules/domain/entities/weekdays.dart';

/// "Ayın 25-i", "İş günləri · Çər istisna", "Həftəlik (Çər, Cüm)", plus the
/// paused months and the end date when the rule has them.
String ruleScheduleLabel(RecurringRule rule) {
  if (rule.isOneOff) return 'Birdəfəlik · ${azDayMonth(rule.startDate)}';
  final end = rule.endDate;
  final excluded = rule.excludedWeekdays;
  return [
    _base(rule),
    if (excluded.isNotEmpty) '${weekdayNames(excluded)} istisna',
    if (rule.skipMonths.isNotEmpty) '${monthNames(rule.skipMonths)} istisna',
    if (end != null) '${azDayMonth(end)} tarixinə qədər',
  ].join(' · ');
}

String _base(RecurringRule rule) => switch (rule.frequency) {
  Frequency.daily => 'Hər gün',
  Frequency.weekdays => 'İş günləri',
  Frequency.weekly => 'Həftəlik (${weekdayNames(rule.activeWeekdays)})',
  Frequency.monthly => 'Ayın ${azDayOrdinal(rule.startDate.day)}',
};

/// One day in full ("Çərşənbə"), several in short ("Çər, Cüm").
String weekdayNames(Set<int> days) {
  final sorted = days.toList()..sort();
  if (sorted.length == 1) return azWeekdays[sorted.single - 1];
  return sorted.map((d) => azWeekdaysShort[d - 1]).join(', ');
}

/// "Avq ayı", "İyl, Avq ayları".
String monthNames(Set<int> months) {
  final sorted = months.toList()..sort();
  final names = sorted.map((m) => azMonthsShort[m - 1]).join(', ');
  return sorted.length == 1 ? '$names ayı' : '$names ayları';
}
