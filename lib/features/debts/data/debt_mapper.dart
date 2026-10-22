import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_payment.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';

extension DebtMapper on Debt {
  Map<String, Object?> toMap() => {
    'person': person,
    'amount': amount,
    'direction': direction.name,
    'due_date': dueDate == null ? null : dayKey(dueDate!),
    'note': note,
    'created_at': createdAt.toIso8601String(),
    'is_closed': isClosed ? 1 : 0,
  };
}

extension DebtPaymentMapper on DebtPayment {
  Map<String, Object?> toMap() => {
    'debt_id': debtId,
    'amount': amount,
    'date': date.toIso8601String(),
  };
}

/// A row of `debts` joined with `SUM(debt_payments.amount) AS paid`.
DebtSummary debtSummaryFromMap(Map<String, Object?> m) => DebtSummary(
  paid: (m['paid'] as num).toDouble(),
  debt: Debt(
    id: m['id'] as int,
    person: m['person'] as String,
    amount: (m['amount'] as num).toDouble(),
    direction: DebtDirection.values.byName(m['direction'] as String),
    dueDate: m['due_date'] == null
        ? null
        : DateTime.parse(m['due_date'] as String),
    note: m['note'] as String?,
    createdAt: DateTime.parse(m['created_at'] as String),
    isClosed: m['is_closed'] == 1,
  ),
);
