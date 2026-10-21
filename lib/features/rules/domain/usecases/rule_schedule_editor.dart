import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/day_flag.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule_copy.dart';
import 'package:flux_wallet/features/rules/domain/entities/rule_exception.dart';
import 'package:flux_wallet/features/rules/domain/repositories/day_flag_repository.dart';
import 'package:flux_wallet/features/rules/domain/repositories/recurring_rule_repository.dart';
import 'package:flux_wallet/features/rules/domain/repositories/rule_exception_repository.dart';

/// Changes how a rule plays out without touching real transactions.
class RuleScheduleEditor {
  const RuleScheduleEditor(this._rules, this._exceptions, this._dayFlags);

  final RecurringRuleRepository _rules;
  final RuleExceptionRepository _exceptions;
  final DayFlagRepository _dayFlags;

  /// "Yalnız bu gün": the rule stays, this one occurrence disappears.
  Future<void> skipOnce(RecurringRule rule, DateTime day) =>
      _exceptions.add(RuleException(ruleId: rule.id!, date: dateOnly(day)));

  /// "Bu gündən sonrakı hamısı": the rule ends the day before [day].
  Future<void> endFrom(RecurringRule rule, DateTime day) {
    final last = addDays(dateOnly(day), -1);
    if (last.isBefore(dateOnly(rule.startDate))) {
      return _rules.setActive(rule.id!, active: false);
    }
    return _rules.update(rule.copyWith(endDate: last));
  }

  Future<void> setDayOff(DateTime day, {required bool off}) =>
      _dayFlags.set(DayFlag(date: dateOnly(day), isNotWorkingDay: off));

  Future<void> setRuleActive(int id, {required bool active}) =>
      _rules.setActive(id, active: active);
}
