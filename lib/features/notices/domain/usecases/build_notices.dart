import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/notices/domain/entities/notice.dart';
import 'package:flux_wallet/features/rules/domain/entities/planned_payment.dart';

/// Pure: turns the raw facts into the ordered list the user should see.
class BuildNotices {
  const BuildNotices({this.soonDays = 3});

  /// How early a due date is worth a heads-up.
  final int soonDays;

  List<Notice> call({
    required int pendingCount,
    required List<PlannedPayment> payments,
    required List<DebtSummary> debts,
    required DateTime today,
  }) {
    final debtNotices = [for (final s in debts) ?_debt(s, today)]
      ..sort((a, b) => a.days.compareTo(b.days));
    return [
      if (pendingCount > 0)
        Notice(NoticeKind.bankMessages, count: pendingCount),
      ...debtNotices,
      for (final p in payments)
        Notice(
          NoticeKind.paymentDue,
          subject: p.rule.title,
          amount: p.rule.amount,
          days: daysBetween(today, p.date),
        ),
    ];
  }

  Notice? _debt(DebtSummary s, DateTime today) {
    final left = s.daysLeft(today);
    if (s.debt.isClosed || s.isSettled || left == null) return null;
    final owedToMe = s.debt.direction == DebtDirection.lent;
    if (owedToMe ? left >= 0 : left > soonDays) return null;
    return Notice(
      owedToMe ? NoticeKind.debtOwed : NoticeKind.debtDue,
      subject: s.debt.person,
      amount: s.remaining,
      days: left,
    );
  }
}
