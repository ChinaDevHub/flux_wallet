import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

/// One line inside a day: a real [transaction], or a planned occurrence of a
/// [rule] that only exists virtually.
class TimelineEntry extends Equatable {
  const TimelineEntry({
    required this.category,
    required this.signedAmount,
    this.title,
    this.rule,
    this.transaction,
    this.account,
    this.skipped = false,
  });

  final String category;

  /// Null means "use the category label".
  final String? title;
  final double signedAmount;
  final RecurringRule? rule;
  final Transaction? transaction;

  /// "Kart" / "Nağd" of a real transaction; planned ones have none yet.
  final String? account;

  /// A planned occurrence switched off for this day only.
  final bool skipped;

  bool get isVirtual => rule != null;

  /// Debt payments are virtual rules without an id: they cannot be switched
  /// off or edited here.
  bool get isEditable => rule?.id != null;
  bool get isIncome => signedAmount > 0;

  /// Counts towards the day's money: real, or planned and not switched off.
  bool get counts => !skipped;

  @override
  List<Object?> get props => [
    category, title, signedAmount, rule, transaction, account, skipped, //
  ];
}
