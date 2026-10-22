import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_state.dart';

extension NewDebtStateMapper on NewDebtState {
  /// Only valid when [canSubmit] is true.
  Debt toDebt() => Debt(
    person: person.trim(),
    amount: amount,
    direction: direction,
    createdAt: date,
    dueDate: dueDate,
    note: note.trim().isEmpty ? null : note.trim(),
  );
}
