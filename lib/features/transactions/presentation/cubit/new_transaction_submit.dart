import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/transactions/domain/usecases/add_transaction.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state_copy.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state_mapper.dart';

/// Saving: the page listens for `done` / `failure`.
mixin NewTransactionSubmit on Cubit<NewTransactionState> {
  AddTransaction get add;

  Future<void> submit() async {
    if (!state.canSubmit) return;
    final s = state;
    emit(s.copyWith(status: SaveStatus.saving));
    try {
      await add(s.toNewTransaction());
      emit(s.copyWith(status: SaveStatus.done));
    } catch (_) {
      emit(s.copyWith(status: SaveStatus.failure));
    }
  }
}
