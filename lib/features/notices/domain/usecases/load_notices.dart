import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/debts/domain/repositories/debt_repository.dart';
import 'package:flux_wallet/features/debts/domain/usecases/load_planning_rules.dart';
import 'package:flux_wallet/features/notices/domain/entities/notice.dart';
import 'package:flux_wallet/features/notices/domain/usecases/build_notices.dart';
import 'package:flux_wallet/features/notifications/domain/repositories/pending_repository.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/usecases/load_schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/plan_builder.dart';

/// Reads what is pending, due and overdue and hands it to [BuildNotices].
class LoadNotices {
  const LoadNotices({
    required this.pending,
    required this.debts,
    required this.planning,
    required this.schedule,
    required this.clock,
  });

  final PendingRepository pending;
  final DebtRepository debts;
  final LoadPlanningRules planning;
  final LoadScheduleContext schedule;
  final Clock clock;

  Future<List<Notice>> call() async {
    final today = dateOnly(clock());
    const build = BuildNotices();
    // Debts are reported from the debt list itself, not as planned bills.
    final bills = const PlanBuilder()(
      await planning(),
      from: today,
      to: addDays(today, build.soonDays),
      ctx: await schedule(today),
      filter: (r) =>
          r.frequency == Frequency.monthly &&
          !r.isIncome &&
          r.category != 'debt',
    );
    return build(
      pendingCount: await pending.countPending(),
      payments: bills,
      debts: await debts.getAll(),
      today: today,
    );
  }
}
