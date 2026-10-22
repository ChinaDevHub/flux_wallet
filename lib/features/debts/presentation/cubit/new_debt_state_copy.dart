import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_state.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';

extension NewDebtStateCopy on NewDebtState {
  /// [clearDue] resets the due date to null.
  NewDebtState copyWith({
    DebtDirection? direction,
    String? person,
    String? amountText,
    String? note,
    DateTime? date,
    DateTime? dueDate,
    bool clearDue = false,
    List<Account>? accounts,
    int? accountId,
    DebtSaveStatus? status,
  }) => NewDebtState(
    direction: direction ?? this.direction,
    person: person ?? this.person,
    amountText: amountText ?? this.amountText,
    date: date ?? this.date,
    dueDate: clearDue ? null : dueDate ?? this.dueDate,
    note: note ?? this.note,
    accounts: accounts ?? this.accounts,
    accountId: accountId ?? this.accountId,
    status: status ?? this.status,
  );
}
