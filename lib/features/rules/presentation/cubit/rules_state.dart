import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

sealed class RulesState extends Equatable {
  const RulesState();

  @override
  List<Object?> get props => const [];
}

class RulesLoading extends RulesState {
  const RulesLoading();
}

class RulesFailure extends RulesState {
  const RulesFailure();
}

class RulesLoaded extends RulesState {
  const RulesLoaded(this.rules);

  final List<RecurringRule> rules;

  List<RecurringRule> get active => rules.where((r) => r.isActive).toList();
  List<RecurringRule> get passive => rules.where((r) => !r.isActive).toList();

  @override
  List<Object?> get props => [rules];
}
