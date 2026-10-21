import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

/// One concrete occurrence of a [RecurringRule].
class PlannedPayment extends Equatable {
  const PlannedPayment({required this.rule, required this.date});

  final RecurringRule rule;
  final DateTime date;

  @override
  List<Object?> get props => [rule, date];
}
