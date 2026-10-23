import 'package:flux_wallet/core/di/use_cases/use_case_deps.dart';
import 'package:flux_wallet/features/budget/domain/usecases/daily_cap.dart';
import 'package:flux_wallet/features/budget/domain/usecases/reset_data.dart';
import 'package:flux_wallet/features/budget/domain/usecases/tracking_start.dart';

/// The user's own budget preferences, where the calendar starts, and reset.
mixin BudgetUseCases on UseCaseDeps {
  late final dailyCap = DailyCap(repos.userSettings);
  late final trackingStart = TrackingStart(
    repos.userSettings,
    repos.users,
    repos.transactions,
  );
  late final resetData = ResetData(repos.reset, trackingStart, clock);
}
