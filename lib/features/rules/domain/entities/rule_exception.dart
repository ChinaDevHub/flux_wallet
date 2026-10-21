import 'package:equatable/equatable.dart';

/// One occurrence of a rule that must not happen on [date].
class RuleException extends Equatable {
  const RuleException({this.id, required this.ruleId, required this.date});

  final int? id;
  final int ruleId;
  final DateTime date;

  @override
  List<Object?> get props => [id, ruleId, date];
}
