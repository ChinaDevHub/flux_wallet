import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/day_flag.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule_copy.dart';
import 'package:flux_wallet/features/rules/domain/entities/rule_exception.dart';
import 'package:flux_wallet/features/rules/domain/repositories/day_flag_repository.dart';
import 'package:flux_wallet/features/rules/domain/repositories/recurring_rule_repository.dart';
import 'package:flux_wallet/features/rules/domain/repositories/rule_exception_repository.dart';

/// Changes how a rule plays out. Days that are over are never rewritten.
class RuleScheduleEditor {
  const RuleScheduleEditor(
    this._rules,
    this._exceptions,
    this._dayFlags,
    this._clock,
  );

  final RecurringRuleRepository _rules;
  final RuleExceptionRepository _exceptions;
  final DayFlagRepository _dayFlags;
  final Clock _clock;

  /// "Yalnız bu gün" off, or back on.
  Future<void> skipOnce(RecurringRule rule, DateTime day) =>
      _exceptions.add(RuleException.on(rule, day));

  Future<void> unskip(RecurringRule rule, DateTime day) =>
      _exceptions.remove(RuleException.on(rule, day));

  /// From [day] on the rule is gone; a rule that never ran is deleted.
  Future<void> endFrom(RecurringRule rule, DateTime day) {
    final first = dateOnly(day);
    if (!first.isAfter(dateOnly(rule.startDate))) {
      return _rules.delete(rule.id!);
    }
    return _rules.update(rule.copyWith(endDate: addDays(first, -1)));
  }

  /// Sil: the rule stops today; what happened before is kept.
  Future<void> delete(RecurringRule rule) => endFrom(rule, _clock());

  /// The switch: off, or on again, from today.
  Future<void> setEnabled(RecurringRule rule, {required bool enabled}) =>
      _rules.setEnabled(rule.id!, enabled: enabled, day: dateOnly(_clock()));

  Future<void> setDayOff(DateTime day, {required bool off}) =>
      _dayFlags.set(DayFlag(date: dateOnly(day), isNotWorkingDay: off));
}
