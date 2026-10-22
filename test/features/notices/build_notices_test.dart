import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/notices/domain/entities/notice.dart';
import 'package:flux_wallet/features/notices/domain/usecases/build_notices.dart';
import 'package:flux_wallet/features/notices/presentation/widgets/notice_text.dart';
import 'package:flux_wallet/features/rules/domain/entities/planned_payment.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

void main() {
  final today = DateTime(2026, 10, 20);
  const build = BuildNotices();

  DebtSummary debt(
    DebtDirection direction,
    int? dueInDays, {
    double paid = 0,
    bool closed = false,
  }) => DebtSummary(
    debt: Debt(
      person: 'Kamal',
      amount: 100,
      direction: direction,
      createdAt: today,
      dueDate: dueInDays == null ? null : DateTime(2026, 10, 20 + dueInDays),
      isClosed: closed,
    ),
    paid: paid,
  );

  List<Notice> run({
    int pending = 0,
    List<DebtSummary> debts = const [],
    List<PlannedPayment> payments = const [],
  }) => build(
    pendingCount: pending,
    payments: payments,
    debts: debts,
    today: today,
  );

  test('nothing to do means no notices', () {
    expect(run(), isEmpty);
  });

  test('waiting bank messages come first, with their count', () {
    final n = run(pending: 2, debts: [debt(DebtDirection.borrowed, 1)]);
    expect(n.first.kind, NoticeKind.bankMessages);
    expect(n.first.count, 2);
  });

  test('a debt I owe is reported when due soon or overdue, not when far', () {
    expect(run(debts: [debt(DebtDirection.borrowed, 3)]).single.days, 3);
    expect(run(debts: [debt(DebtDirection.borrowed, -2)]).single.days, -2);
    expect(run(debts: [debt(DebtDirection.borrowed, 4)]), isEmpty);
    expect(run(debts: [debt(DebtDirection.borrowed, null)]), isEmpty);
  });

  test('money owed to me is reported only once it is overdue', () {
    final late = run(debts: [debt(DebtDirection.lent, -1)]).single;
    expect(late.kind, NoticeKind.debtOwed);
    expect(run(debts: [debt(DebtDirection.lent, 1)]), isEmpty);
  });

  test('settled and closed debts are never reported', () {
    expect(run(debts: [debt(DebtDirection.borrowed, -1, paid: 100)]), isEmpty);
    expect(
      run(debts: [debt(DebtDirection.borrowed, -1, closed: true)]),
      isEmpty,
    );
  });

  test('overdue debts are listed before the ones still ahead', () {
    final n = run(
      debts: [
        debt(DebtDirection.borrowed, 2),
        debt(DebtDirection.borrowed, -3),
      ],
    );
    expect(n.map((x) => x.days), [-3, 2]);
  });

  test('bills carry their days and amount', () {
    final rent = RecurringRule(
      title: 'Kirayə',
      amount: 300,
      category: 'rent',
      frequency: Frequency.monthly,
      startDate: DateTime(2026, 1, 22),
    );
    final n = run(
      payments: [PlannedPayment(rule: rent, date: DateTime(2026, 10, 22))],
    );
    expect(n.single.kind, NoticeKind.paymentDue);
    expect(
      [n.single.subject, n.single.amount, n.single.days],
      ['Kirayə', 300, 2],
    );
  });

  test('the words read naturally', () {
    expect(
      const Notice(NoticeKind.bankMessages, count: 3).title,
      '3 bank bildirişi təsdiq gözləyir',
    );
    const due = Notice(
      NoticeKind.debtDue,
      subject: 'Kamal',
      amount: 65,
      days: 1,
    );
    expect(due.detail, 'Sabah · 65.00 ₼');
    const late = Notice(
      NoticeKind.debtOwed,
      subject: 'Aysel',
      amount: 20,
      days: -4,
    );
    expect(late.title, 'Aysel borcunu qaytarmayıb');
    expect(late.detail, '4 gün gecikib · 20.00 ₼');
  });
}
