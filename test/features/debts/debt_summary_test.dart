import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';

void main() {
  final today = DateTime(2026, 10, 20);
  DebtSummary summary(double paid, {DateTime? due, double amount = 100}) =>
      DebtSummary(
        paid: paid,
        debt: Debt(
          person: 'Kamal',
          amount: amount,
          direction: DebtDirection.borrowed,
          createdAt: today,
          dueDate: due,
        ),
      );

  test('remaining and progress follow what was paid', () {
    final s = summary(25);
    expect([s.remaining, s.progress, s.isSettled], [75, 0.25, false]);
  });

  test('over-payment never goes below zero and counts as settled', () {
    final s = summary(120);
    expect([s.remaining, s.progress, s.isSettled], [0, 1, true]);
  });

  test('days left and overdue depend on the due date', () {
    expect(summary(0, due: DateTime(2026, 10, 27)).daysLeft(today), 7);
    expect(summary(0, due: DateTime(2026, 10, 27)).isOverdue(today), isFalse);
    expect(summary(0, due: DateTime(2026, 10, 19)).isOverdue(today), isTrue);
    expect(summary(100, due: DateTime(2026, 10, 19)).isOverdue(today), isFalse);
    expect(summary(0).daysLeft(today), isNull);
  });
}
