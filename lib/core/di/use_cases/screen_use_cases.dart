import 'package:flux_wallet/core/di/use_cases/budget_use_cases.dart';
import 'package:flux_wallet/core/di/use_cases/debt_use_cases.dart';
import 'package:flux_wallet/core/di/use_cases/schedule_use_cases.dart';
import 'package:flux_wallet/features/home/domain/usecases/load_home_snapshot.dart';
import 'package:flux_wallet/features/notices/domain/usecases/load_notices.dart';
import 'package:flux_wallet/features/statistics/domain/usecases/load_statistics.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/load_calendar_bounds.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/load_timeline.dart';

/// The loaders behind the main tabs.
mixin ScreenUseCases on ScheduleUseCases, DebtUseCases, BudgetUseCases {
  late final loadStatistics = LoadStatistics(repos.transactions, clock);
  late final loadTimeline = LoadTimeline(
    accounts: repos.accounts,
    transactions: repos.transactions,
    planning: planningRules,
    schedule: loadSchedule,
    cap: dailyCap,
    clock: clock,
  );
  late final loadCalendarBounds = LoadCalendarBounds(trackingStart, clock);
  late final loadNotices = LoadNotices(
    pending: repos.pending,
    debts: repos.debts,
    planning: planningRules,
    schedule: loadSchedule,
    clock: clock,
  );
  late final loadHome = LoadHomeSnapshot(
    users: repos.users,
    accounts: repos.accounts,
    transactions: repos.transactions,
    planning: planningRules,
    schedule: loadSchedule,
    pending: repos.pending,
    cap: dailyCap,
    clock: clock,
  );
}
