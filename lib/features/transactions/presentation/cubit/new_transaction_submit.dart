import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/transactions/domain/usecases/add_transaction.dart';
import 'package:flux_wallet/features/transactions/domain/usecases/change_transaction.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state_copy.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state_mapper.dart';

/// Saving: adds a new transaction (or plan), or applies an edit. The page
/// listens for `done` / `failure`.
mixin NewTransactionSubmit on Cubit<NewTransactionState> {
  AddTransaction get add;
  ChangeTransaction get change;

  Future<void> submit() async {
    if (!state.canSubmit) return;
    final s = state;
    emit(s.copyWith(status: SaveStatus.saving));
    try {
      final old = s.editing;
      if (old == null) {
        await add(s.toNewTransaction());
      } else {
        await change.update(old, s.toTransaction());
      }
      emit(s.copyWith(status: SaveStatus.done));
    } catch (_) {
      emit(s.copyWith(status: SaveStatus.failure));
    }
  }
}
