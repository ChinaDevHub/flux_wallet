import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule_live.dart';
import 'package:flux_wallet/features/rules/domain/repositories/recurring_rule_repository.dart';
import 'package:flux_wallet/features/rules/domain/usecases/rule_schedule_editor.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rules_state.dart';

class RulesCubit extends ReloadingCubit<RulesState> {
  RulesCubit(this._rules, this._editor, this._clock, Stream<void> changes)
    : super(const RulesLoading(), changes);

  final RecurringRuleRepository _rules;
  final RuleScheduleEditor _editor;
  final Clock _clock;

  @override
  Future<void> load() async {
    try {
      final today = dateOnly(_clock());
      final live =
          (await _rules.getAll()).where((r) => r.isLive(today)).toList()
            ..sort((a, b) => a.title.compareTo(b.title));
      emit(RulesLoaded(live));
    } catch (_) {
      emit(const RulesFailure());
    }
  }

  // Each write triggers a reload, so the list updates by itself.
  Future<void> toggle(RecurringRule rule, bool on) =>
      _editor.setEnabled(rule, enabled: on);

  Future<void> delete(RecurringRule rule) => _editor.delete(rule);
}
