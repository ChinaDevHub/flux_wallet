import 'package:flux_wallet/core/di/use_cases/use_case_deps.dart';
import 'package:flux_wallet/features/settings/domain/usecases/reset_data.dart';

/// Starting over from zero.
mixin BudgetUseCases on UseCaseDeps {
  late final resetData = ResetData(repos.reset);
}
