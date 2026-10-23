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

/// Every live rule in one list, switched on or off.
class RulesLoaded extends RulesState {
  const RulesLoaded(this.rules);

  final List<RecurringRule> rules;

  @override
  List<Object?> get props => [rules];
}
