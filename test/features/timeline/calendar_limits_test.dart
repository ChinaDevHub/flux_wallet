import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/auth/domain/usecases/resolve_session.dart';
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

  test('a past day over its own limit carries the red dot', () async {
    await env.repos.transactions.add(spend(50, DateTime(2026, 10, 18, 12)));
    final view = await env.useCases.loadTimeline(DateTime(2026, 10));
    final day = view.days.firstWhere((d) => d.date.day == 18);
    // That morning: 300 ₼ and 11 days to the salary on the 29th.
    expect(day.limit!.budget, closeTo(300 / 11, 0.01));
    expect(day.isOver, isTrue);
    expect(view.days.firstWhere((d) => d.date.day == 17).isOver, isFalse);
    expect(view.days.firstWhere((d) => d.date.day == 25).limit, isNull);
  });

  test('the calendar starts with the first transaction, else today', () async {
    var bounds = await env.useCases.loadCalendarBounds();
    expect(bounds.first, DateTime(2026, 10, 20));
    expect(bounds.last, DateTime(2027, 1, 31));
    await env.repos.transactions.add(spend(1, DateTime(2026, 9, 3, 12)));
    bounds = await env.useCases.loadCalendarBounds();
    expect(bounds.first, DateTime(2026, 9, 3));
  });

  test('reset wipes the money and the calendar starts over', () async {
    await env.repos.transactions.add(spend(1, DateTime(2026, 9, 3, 12)));
    await env.useCases.resetData();
    expect(await env.repos.accounts.getAll(), isEmpty);
    expect(await env.repos.rules.getAll(), isEmpty);
    expect(await env.useCases.resolveSession(), SessionState.onboarding);
    final bounds = await env.useCases.loadCalendarBounds();
    expect(bounds.first, DateTime(2026, 10, 20));
  });
}
