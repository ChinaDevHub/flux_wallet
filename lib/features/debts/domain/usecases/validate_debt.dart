import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';

/// A debt needs a person and an amount, may be dated in the past but never
/// the future, and a borrowed one must say when it is due (that date joins
/// the mandatory expenses and so lowers the daily limit).
void validateDebt(Debt debt, DateTime now) {
  if (debt.person.trim().isEmpty) throw ArgumentError('person');
  if (debt.amount <= 0) throw ArgumentError.value(debt.amount, 'amount');
  final day = dateOnly(debt.createdAt);
  if (day.isAfter(dateOnly(now))) throw ArgumentError('In the future');
  final due = debt.dueDate;
  if (debt.direction == DebtDirection.borrowed && due == null) {
    throw ArgumentError('A borrowed debt needs a due date');
  }
  if (due != null && dateOnly(due).isBefore(day)) {
    throw ArgumentError('Due date is before the debt');
  }
}
