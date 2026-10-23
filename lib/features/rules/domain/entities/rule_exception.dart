import 'package:equatable/equatable.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

/// One occurrence of a rule that must not happen on [date].
class RuleException extends Equatable {
  const RuleException({this.id, required this.ruleId, required this.date});

  /// [rule] skipped on [day].
  RuleException.on(RecurringRule rule, DateTime day)
    : this(ruleId: rule.id!, date: dateOnly(day));

  final int? id;
  final int ruleId;
  final DateTime date;

  @override
  List<Object?> get props => [id, ruleId, date];
}
