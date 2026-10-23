import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/auth/domain/usecases/resolve_session.dart';
import 'package:flux_wallet/features/budget/domain/usecases/daily_cap.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import '../../support/test_env.dart';

Transaction spend(double amount, DateTime at) => Transaction(
  amount: amount,
  type: TxType.expense,
  category: 'cafe',
  accountId: 1,
  date: at,
);

void main() {
  final now = DateTime(2026, 10, 20, 9);
  late TestEnv env;

  setUp(() async {
    env = await openTestEnv(now: now);
    await env.repos.onboarding.complete(
      const OnboardingData(
        cardBalance: 300,
        cashBalance: 0,
        salaryAmount: 1000,
        salaryDay: 29,
      ),
      now,
    );
  });
  tearDown(() => env.close());

  test('the daily cap only ever lowers the computed limit', () {
    expect(DailyCap.effective(33.3, null), 33.3);
    expect(DailyCap.effective(33.3, 20), 20);
    expect(DailyCap.effective(33.3, 50), 33.3);
  });

  test('the cap is per user and shows up on Home', () async {
    await env.useCases.dailyCap.write(15);
    expect((await env.useCases.loadHome()).dailyBudget, 15);
    await env.useCases.dailyCap.clear();
    expect((await env.useCases.loadHome()).dailyBudget, greaterThan(15));
    await env.useCases.dailyCap.write(10);
    await env.switchTo('aysel');
    expect(await env.useCases.dailyCap.read(), isNull);
  });

  test(
    'a day over its cap carries the red dot; the limit is per day',
    () async {
      await env.useCases.dailyCap.write(20);
      await env.repos.transactions.add(spend(25, DateTime(2026, 10, 18, 12)));
      final view = await env.useCases.loadTimeline(DateTime(2026, 10));
      final day = view.days.firstWhere((d) => d.date.day == 18);
      expect(day.isOver, isTrue);
      expect(day.limit!.over, closeTo(5, 0.001));
      expect(view.days.firstWhere((d) => d.date.day == 17).isOver, isFalse);
      expect(view.days.firstWhere((d) => d.date.day == 25).limit, isNull);
    },
  );

  test('the calendar runs from the first day to three months ahead', () async {
    final bounds = await env.useCases.loadCalendarBounds();
    expect(bounds.first, DateTime(2026, 10, 20));
    expect(bounds.last, DateTime(2027, 1, 31));
    await env.repos.transactions.add(spend(1, DateTime(2026, 9, 3)));
    final moved = await env.useCases.loadCalendarBounds();
    expect(moved.first, DateTime(2026, 9, 3));
  });

  test(
    'reset wipes the money, keeps the account, restarts the calendar',
    () async {
      await env.repos.transactions.add(spend(1, now));
      await env.useCases.resetData();
      expect(await env.repos.accounts.getAll(), isEmpty);
      expect(await env.repos.rules.getAll(), isEmpty);
      expect(await env.useCases.resolveSession(), SessionState.onboarding);
      final bounds = await env.useCases.loadCalendarBounds();
      expect(bounds.first, DateTime(2026, 10, 20));
    },
  );
}
