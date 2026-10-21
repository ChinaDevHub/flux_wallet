import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

extension RecurringRuleCopy on RecurringRule {
  /// Only the two fields that change after creation.
  RecurringRule copyWith({DateTime? endDate, bool? isActive}) => RecurringRule(
    id: id,
    title: title,
    amount: amount,
    category: category,
    frequency: frequency,
    startDate: startDate,
    endDate: endDate ?? this.endDate,
    isActive: isActive ?? this.isActive,
    type: type,
  );
}
