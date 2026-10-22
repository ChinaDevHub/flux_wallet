import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/usecases/create_debt.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_state.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_state_copy.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_state_mapper.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/account_repository.dart';

class NewDebtCubit extends Cubit<NewDebtState> {
  NewDebtCubit(this._create, this._accounts, Clock clock)
    : super(NewDebtState(date: dateOnly(clock())));

  final CreateDebt _create;
  final AccountRepository _accounts;

  Future<void> init() async {
    final all = await _accounts.getAll();
    emit(state.copyWith(accounts: all, accountId: all.firstOrNull?.id));
  }

  void setDirection(DebtDirection d) => emit(state.copyWith(direction: d));
  void setPerson(String v) => emit(state.copyWith(person: v));
  void setAmount(String v) => emit(state.copyWith(amountText: v));
  void setNote(String v) => emit(state.copyWith(note: v));
  void setAccount(int id) => emit(state.copyWith(accountId: id));
  void setDue(DateTime d) => emit(state.copyWith(dueDate: d));

  /// A due date that now falls before the debt itself is dropped.
  void setDate(DateTime d) {
    final day = dateOnly(d);
    final due = state.dueDate;
    emit(state.copyWith(date: day, clearDue: due != null && due.isBefore(day)));
  }

  Future<void> submit() async {
    if (!state.canSubmit) return;
    final s = state;
    emit(s.copyWith(status: DebtSaveStatus.saving));
    try {
      await _create(s.toDebt(), accountId: s.accountId!);
      emit(s.copyWith(status: DebtSaveStatus.done));
    } catch (_) {
      emit(s.copyWith(status: DebtSaveStatus.failure));
    }
  }
}
