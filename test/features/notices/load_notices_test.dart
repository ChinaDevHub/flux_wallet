import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/notices/domain/entities/notice.dart';
import 'package:flux_wallet/features/notifications/domain/entities/raw_notification.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import '../../support/test_env.dart';

void main() {
  final now = DateTime(2026, 10, 20, 9);
  late TestEnv env;

  setUp(() async {
    env = await openTestEnv(now: now);
    await env.repos.onboarding.complete(
      const OnboardingData(cardBalance: 500, cashBalance: 0),
      now,
    );
  });

  tearDown(() => env.close());

  RecurringRule bill(String title, int day) => RecurringRule(
    title: title,
    amount: 300,
    category: 'rent',
    frequency: Frequency.monthly,
    startDate: DateTime(2026, 1, day),
  );

  test('gathers messages, debts and bills for the signed-in user', () async {
    await env.repos.rules.add(bill('Kirayə', 23));
    await env.repos.rules.add(bill('İnternet', 29));
    await env.useCases.createDebt(
      Debt(
        person: 'Kamal',
        amount: 100,
        direction: DebtDirection.borrowed,
        createdAt: now,
        dueDate: DateTime(2026, 10, 22),
      ),
    );
    await env.useCases.ingest(
      RawNotification(
        text: 'Kart +1234: BOLT.EU 5.00 AZN 20.10 08:00',
        receivedAt: now,
      ),
    );
    final notices = await env.useCases.loadNotices();
    expect(notices.map((n) => n.kind), [
      NoticeKind.bankMessages,
      NoticeKind.debtDue,
      NoticeKind.paymentDue,
    ]);
    expect(notices.last.subject, 'Kirayə');
  });

  test('a debt does not also show up as a bill', () async {
    await env.useCases.createDebt(
      Debt(
        person: 'Kamal',
        amount: 100,
        direction: DebtDirection.borrowed,
        createdAt: now,
        dueDate: DateTime(2026, 10, 21),
      ),
    );
    final kinds = (await env.useCases.loadNotices()).map((n) => n.kind);
    expect(kinds, [NoticeKind.debtDue]);
  });

  test('another user does not see them', () async {
    await env.repos.rules.add(bill('Kirayə', 23));
    await env.switchTo('other');
    expect(await env.useCases.loadNotices(), isEmpty);
  });
}
