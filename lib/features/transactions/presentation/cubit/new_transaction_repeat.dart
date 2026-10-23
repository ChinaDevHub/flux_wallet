import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan_copy.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state_copy.dart';

/// The "Təkrarla" part of the form.
mixin NewTransactionRepeat on Cubit<NewTransactionState> {
  /// A weekly plan follows the transaction to its new weekday.
  void setDate(DateTime date) {
    final day = dateOnly(date);
    emit(state.copyWith(date: day, repeat: state.repeat?.rebase(day)));
  }

  /// Picking a frequency starts a fresh plan with its usual days.
  void setRepeat(Frequency? f) => emit(
    state.copyWith(
      repeat: f == null ? null : RecurrencePlan.of(f, state.date),
      clearRepeat: f == null,
    ),
  );

  void updateRepeat(RecurrencePlan plan) => emit(state.copyWith(repeat: plan));
}
