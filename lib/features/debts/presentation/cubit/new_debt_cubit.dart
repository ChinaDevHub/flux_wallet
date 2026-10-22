import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/usecases/create_debt.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_state.dart';

class NewDebtCubit extends Cubit<NewDebtState> {
  NewDebtCubit(this._create, this._clock) : super(const NewDebtState());

  final CreateDebt _create;
  final Clock _clock;

  void setDirection(DebtDirection d) => emit(state.copyWith(direction: d));
  void setPerson(String v) => emit(state.copyWith(person: v));
  void setAmount(String v) => emit(state.copyWith(amountText: v));
  void setNote(String v) => emit(state.copyWith(note: v));
  void setDue(DateTime? d) =>
      emit(state.copyWith(dueDate: d, clearDue: d == null));

  Future<void> submit() async {
    if (!state.canSubmit) return;
    final s = state;
    emit(s.copyWith(status: DebtSaveStatus.saving));
    try {
      await _create(
        Debt(
          person: s.person.trim(),
          amount: s.amount,
          direction: s.direction,
          createdAt: _clock(),
          dueDate: s.dueDate,
          note: s.note.trim().isEmpty ? null : s.note.trim(),
        ),
      );
      emit(s.copyWith(status: DebtSaveStatus.done));
    } catch (_) {
      emit(s.copyWith(status: DebtSaveStatus.failure));
    }
  }
}
