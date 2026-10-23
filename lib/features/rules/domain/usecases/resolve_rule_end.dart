import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_end.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/usecases/recurrence_expander.dart';

/// Turns the chosen [RecurrenceEnd] into the rule's last day, so the engine
/// only ever deals with a plain end date.
class ResolveRuleEnd {
  const ResolveRuleEnd([this._expander = const RecurrenceExpander()]);

  final RecurrenceExpander _expander;

  /// Far enough for a 30-year mortgage; counting stops at the horizon.
  static const _horizonYears = 30;

  DateTime? call(RecurringRule draft, RecurrenceEnd end) => switch (end) {
    NeverEnds() => null,
    EndsOn(:final date) => dateOnly(date),
    EndsAfter(:final count) => _nth(draft, count),
  };

  /// The [count]-th occurrence, the start day being the first.
  DateTime _nth(RecurringRule draft, int count) {
    final start = dateOnly(draft.startDate);
    final horizon = DateTime(start.year + _horizonYears, start.month);
    final dates = _expander.expand(draft, start, horizon);
    if (dates.isEmpty) return start;
    return dates[(count - 1).clamp(0, dates.length - 1)];
  }
}
