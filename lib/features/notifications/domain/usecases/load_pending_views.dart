import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/notifications/domain/entities/pending_view.dart';
import 'package:flux_wallet/features/notifications/domain/repositories/pending_repository.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/repositories/recurring_rule_repository.dart';
import 'package:flux_wallet/features/rules/domain/usecases/load_schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/plan_builder.dart';

/// The queue, each item with the bus fare planned for its day (if any).
class LoadPendingViews {
  const LoadPendingViews(this._pending, this._rules, this._schedule);

  final PendingRepository _pending;
  final RecurringRuleRepository _rules;
  final LoadScheduleContext _schedule;

  Future<List<PendingView>> call() async {
    final items = await _pending.getPending();
    if (items.isEmpty) return const [];
    final rules = await _rules.getActive();
    final earliest = items
        .map((p) => dateOnly(p.occurredAt))
        .reduce((a, b) => a.isBefore(b) ? a : b);
    final ctx = await _schedule(earliest);
    return [
      for (final p in items)
        PendingView(
          pending: p,
          replaceableBus: _busOn(rules, dateOnly(p.occurredAt), ctx),
        ),
    ];
  }

  RecurringRule? _busOn(List<RecurringRule> rules, DateTime day, ctx) {
    final plans = const PlanBuilder()(
      rules,
      from: day,
      to: day,
      ctx: ctx,
      filter: (r) => r.category == 'bus' && !r.isIncome,
    );
    return plans.firstOrNull?.rule;
  }
}
