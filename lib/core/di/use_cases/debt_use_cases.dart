import 'package:flux_wallet/core/di/use_cases/use_case_deps.dart';
import 'package:flux_wallet/features/debts/domain/usecases/create_debt.dart';
import 'package:flux_wallet/features/debts/domain/usecases/edit_debt.dart';
import 'package:flux_wallet/features/debts/domain/usecases/load_planning_rules.dart';
import 'package:flux_wallet/features/debts/domain/usecases/record_debt_payment.dart';

mixin DebtUseCases on UseCaseDeps {
  late final planningRules = LoadPlanningRules(repos.rules, repos.debts, clock);
  late final createDebt = CreateDebt(repos.debts, clock);
  late final editDebt = EditDebt(repos.debts, clock);
  late final recordDebtPayment = RecordDebtPayment(repos.debts, clock);
}
