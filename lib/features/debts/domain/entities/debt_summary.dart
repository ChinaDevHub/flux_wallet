import 'package:equatable/equatable.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';

/// A debt together with what has been paid back so far.
class DebtSummary extends Equatable {
  const DebtSummary({required this.debt, required this.paid});

  final Debt debt;
  final double paid;

  double get remaining => (debt.amount - paid).clamp(0, debt.amount);

  /// 0..1, for the progress bar.
  double get progress =>
      debt.amount <= 0 ? 1 : (paid / debt.amount).clamp(0.0, 1.0);

  bool get isSettled => remaining < 0.005;

  /// Overdue only from the day after the due date, whatever time of day
  /// [today] carries.
  bool isOverdue(DateTime today) =>
      !isSettled &&
      debt.dueDate != null &&
      dateOnly(debt.dueDate!).isBefore(dateOnly(today));

  int? daysLeft(DateTime today) =>
      debt.dueDate == null ? null : daysBetween(today, dateOnly(debt.dueDate!));

  @override
  List<Object?> get props => [debt, paid];
}
