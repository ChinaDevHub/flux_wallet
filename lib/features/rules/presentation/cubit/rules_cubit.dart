import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/features/rules/domain/repositories/recurring_rule_repository.dart';
import 'package:flux_wallet/features/rules/domain/usecases/rule_schedule_editor.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rules_state.dart';

class RulesCubit extends ReloadingCubit<RulesState> {
  RulesCubit(this._rules, this._editor, Stream<void> changes)
    : super(const RulesLoading(), changes);

  final RecurringRuleRepository _rules;
  final RuleScheduleEditor _editor;

  @override
  Future<void> load() async {
    try {
      final all = await _rules.getAll();
      all.sort((a, b) => a.title.compareTo(b.title));
      emit(RulesLoaded(all));
    } catch (_) {
      emit(const RulesFailure());
    }
  }

  /// The write triggers a reload, so the list updates by itself.
  Future<void> toggle(int id, bool active) =>
      _editor.setRuleActive(id, active: active);
}
