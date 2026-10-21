import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_kind.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/account_repository.dart';
import 'package:flux_wallet/features/transactions/domain/usecases/add_transaction.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state_copy.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state_mapper.dart';

class NewTransactionCubit extends Cubit<NewTransactionState> {
  NewTransactionCubit(this._add, this._accounts, Clock clock)
    : super(NewTransactionState(date: dateOnly(clock())));

  final AddTransaction _add;
  final AccountRepository _accounts;

  Future<void> init() async {
    final all = await _accounts.getAll();
    emit(state.copyWith(accounts: all, accountId: all.firstOrNull?.id));
  }

  void setKind(TransactionKind kind) =>
      emit(state.copyWith(kind: kind, clearCategory: true));
  void setAmountText(String text) => emit(state.copyWith(amountText: text));
  void addAmount(double delta) =>
      emit(state.copyWith(amountText: formatPlain(state.amount + delta)));

  void setCategory(String category) => emit(state.copyWith(category: category));
  void setAccount(int id) => emit(state.copyWith(accountId: id));
  void setDate(DateTime date) => emit(state.copyWith(date: dateOnly(date)));
  void setNote(String note) => emit(state.copyWith(note: note));

  void setRepeat(Frequency? repeat) =>
      emit(state.copyWith(repeat: repeat, clearRepeat: repeat == null));

  Future<void> submit() async {
    if (!state.canSubmit) return;
    final s = state;
    emit(s.copyWith(status: SaveStatus.saving));
    try {
      await _add(s.toNewTransaction());
      emit(s.copyWith(status: SaveStatus.done));
    } catch (_) {
      emit(s.copyWith(status: SaveStatus.failure));
    }
  }
}
