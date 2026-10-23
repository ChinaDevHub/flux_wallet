import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan_copy.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/usecases/revise_rule.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rule_edit_start.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rule_edit_state.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rule_edit_state_copy.dart';

/// Edits one rule. A change applies from [RuleEditState.from] on and never
/// to days that are over (see `ReviseRule`).
class RuleEditCubit extends Cubit<RuleEditState> {
  RuleEditCubit(RecurringRule rule, this._revise, Clock clock, {DateTime? from})
    : super(startRuleEdit(rule, dateOnly(clock()), from));

  final ReviseRule _revise;

  void setTitle(String v) => emit(state.copyWith(title: v));
  void setAmountText(String v) => emit(state.copyWith(amountText: v));
  void setCategory(String v) => emit(state.copyWith(category: v));
  void setPlan(RecurrencePlan plan) => emit(state.copyWith(plan: plan));

  void setFrequency(Frequency? f) {
    if (f == null) return;
    emit(state.copyWith(plan: state.plan.withFrequency(f, state.from)));
  }

  void setFrom(DateTime date) {
    final day = dateOnly(date);
    emit(state.copyWith(from: day, plan: state.plan.rebase(day)));
  }

  Future<void> submit() async {
    if (!state.canSubmit) return;
    final s = state;
    emit(s.copyWith(status: RuleSaveStatus.saving));
    try {
      await _revise(s.rule, s.edit);
      emit(s.copyWith(status: RuleSaveStatus.done));
    } catch (_) {
      emit(s.copyWith(status: RuleSaveStatus.failure));
    }
  }
}
