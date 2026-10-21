import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

extension RecurringRuleMapper on RecurringRule {
  Map<String, Object?> toMap() => {
    'id': id,
    'title': title,
    'amount': amount,
    'category': category,
    'type': type.name,
    'frequency': frequency.name,
    'start_date': dayKey(startDate),
    'end_date': endDate == null ? null : dayKey(endDate!),
    'is_active': isActive ? 1 : 0,
  };
}

RecurringRule ruleFromMap(Map<String, Object?> m) => RecurringRule(
  id: m['id'] as int,
  title: m['title'] as String,
  amount: (m['amount'] as num).toDouble(),
  category: m['category'] as String,
  type: TxType.values.byName(m['type'] as String),
  frequency: Frequency.values.byName(m['frequency'] as String),
  startDate: DateTime.parse(m['start_date'] as String),
  endDate: m['end_date'] == null
      ? null
      : DateTime.parse(m['end_date'] as String),
  isActive: m['is_active'] == 1,
);
