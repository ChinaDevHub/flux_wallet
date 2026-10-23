import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/debts_cubit.dart';

DebtsCubit newDebtsCubit(AppDependencies deps) => DebtsCubit(
  deps.repos.debts,
  deps.useCases.recordDebtPayment,
  deps.useCases.editDebt,
  deps.repos.accounts,
  deps.changes,
)..load();
