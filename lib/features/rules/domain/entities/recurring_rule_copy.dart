import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

extension RecurringRuleCopy on RecurringRule {
  RecurringRule copyWith({
    int? id,
    DateTime? endDate,
    bool? isActive,
    Set<int>? weekdays,
    Set<int>? skipMonths,
  }) => RecurringRule(
    id: id ?? this.id,
    title: title,
    amount: amount,
    category: category,
    frequency: frequency,
    startDate: startDate,
    endDate: endDate ?? this.endDate,
    isActive: isActive ?? this.isActive,
    type: type,
    weekdays: weekdays ?? this.weekdays,
    skipMonths: skipMonths ?? this.skipMonths,
  );
}
