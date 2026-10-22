import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

/// One line inside a day: a real transaction, or a planned occurrence of a
/// [rule] that only exists virtually.
class TimelineEntry extends Equatable {
  const TimelineEntry({
    required this.category,
    required this.signedAmount,
    this.title,
    this.rule,
  });

  final String category;

  /// Null means "use the category label".
  final String? title;
  final double signedAmount;
  final RecurringRule? rule;

  bool get isVirtual => rule != null;

  /// Debt payments are virtual rules without an id: they cannot be skipped.
  bool get isEditable => rule?.id != null;
  bool get isIncome => signedAmount > 0;

  @override
  List<Object?> get props => [category, title, signedAmount, rule];
}
