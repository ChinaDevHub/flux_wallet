import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule_copy.dart';
import 'package:flux_wallet/features/rules/domain/repositories/recurring_rule_repository.dart';
import 'package:flux_wallet/features/rules/domain/usecases/rule_edit.dart';
import 'package:flux_wallet/features/rules/domain/usecases/rule_edit_apply.dart';

/// "Redaktə et": a change applies from a day on and never to days that are
/// over. A rule that already ran is split in two (old ends, new starts), so
/// the past keeps its amounts, days and the limits that followed from them.
class ReviseRule {
  const ReviseRule(this._rules, this._clock);

  final RecurringRuleRepository _rules;
  final Clock _clock;

  Future<void> call(RecurringRule old, RuleEdit edit) async {
    final today = dateOnly(_clock());
    final applied = edit.startingNoEarlierThan(today);
    if (!applied.isValid) throw ArgumentError('Invalid rule edit');
    final next = applied.applyTo(old);
    if (!dateOnly(old.startDate).isBefore(today)) {
      return _rules.update(next.copyWith(id: old.id));
    }
    return _rules.revise(old, next, applied.from);
  }
}
