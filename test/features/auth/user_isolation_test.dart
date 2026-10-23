import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/notifications/domain/entities/raw_notification.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import '../../support/test_env.dart';

void main() {
  final now = DateTime(2026, 10, 20, 9);
  final from = DateTime(2026, 1, 1);
  late TestEnv env;

  /// Runs [read] while [username] is signed in.
  Future<T> asUser<T>(String username, Future<T> Function() read) async {
    await env.useCases.loginUser(username, 'secret123');
    return read();
  }

  /// Everything the signed-in user can see, through every read path.
  Future<Map<String, Object?>> view() async {
    final r = env.repos;
    final schedule = await env.useCases.loadSchedule(from);
    return {
      'accounts': (await r.accounts.getAll()).map((a) => a.name).toList(),
      'transactions': (await r.transactions.getBetween(
        DateTime(2026),
        DateTime(2027),
      )).length,
      'rules': (await r.rules.getAll()).map((x) => x.title).toList(),
      'offDays': schedule.offDays.length,
      'exceptions': schedule.exceptions.length,
      'pending': await r.pending.countPending(),
      'merchant': await r.merchants.categoryFor('BOLT EU'),
      'debts': (await r.debts.getAll()).length,
      'balance': (await r.accounts.getAll()).fold<double>(
        0,
        (t, a) => t + a.balance,
      ),
      'homeBase': (await env.useCases.loadHome()).limit.totalBalance,
      'expense': (await env.useCases.loadStatistics()).months.last.expense,
    };
  }

  setUp(() async {
    env = await openTestEnv(now: now, username: 'alice');
    final r = env.repos, u = env.useCases;
    await r.onboarding.complete(
      const OnboardingData(
        cardBalance: 500,
        cashBalance: 20,
        salaryAmount: 1000,
        salaryDay: 29,
      ),
      now,
    );
    final accountId = (await r.accounts.getAll()).first.id!;
    await r.rules.add(
      RecurringRule(
        title: 'Avtobus',
        amount: 1,
        category: 'bus',
        frequency: Frequency.weekdays,
        startDate: DateTime(2026, 1, 1),
      ),
    );
    await u.scheduleEditor.skipOnce(
      (await r.rules.getAll()).firstWhere((x) => x.title == 'Avtobus'),
      DateTime(2026, 10, 21),
    );
    await u.scheduleEditor.setDayOff(DateTime(2026, 10, 22), off: true);
    await r.transactions.add(
      Transaction(
        amount: 9,
        type: TxType.expense,
        category: 'cafe',
        accountId: accountId,
        date: now,
      ),
    );
    await u.createDebt(
      Debt(
        person: 'Kamal',
        amount: 50,
        direction: DebtDirection.borrowed,
        createdAt: now,
        dueDate: DateTime(2026, 10, 25),
      ),
      accountId: accountId,
    );
    await u.ingest(
      RawNotification(
        text: 'Kart +1234: BOLT.EU 5.00 AZN 20.10 08:00',
        receivedAt: now,
      ),
    );
    await r.merchants.remember('BOLT EU', 'taxi');
    await env.switchTo('bob');
  });

  tearDown(() => env.close());

  test('a new user starts empty in every read path', () async {
    final v = await view();
    expect(v['accounts'], isEmpty);
    expect(v['transactions'], 0);
    expect(v['rules'], isEmpty);
    expect(v['offDays'], 0);
    expect(v['exceptions'], 0);
    expect(v['pending'], 0);
    expect(v['merchant'], isNull);
    expect(v['debts'], 0);
    expect(v['balance'], 0);
    expect(v['expense'], 0);
  });

  test(
    'users keep their own data side by side and get it back on sign-in',
    () async {
      await env.repos.onboarding.complete(
        const OnboardingData(cardBalance: 7, cashBalance: 0),
        now,
      );
      await env.repos.merchants.remember('BOLT EU', 'other');

      final alice = await asUser('alice', view);
      expect(alice['accounts'], ['Kart', 'Nağd']);
      expect(alice['transactions'], 2); // a cafe spend + the debt's money in
      expect(alice['rules'], ['Maaş', 'Avtobus']);
      expect(alice['offDays'], 1);
      expect(alice['exceptions'], 1);
      expect(alice['pending'], 1);
      expect(alice['merchant'], 'taxi');
      expect(alice['debts'], 1);
      expect(alice['balance'], 561); // 520 - 9 + 50 borrowed
      expect(alice['homeBase'], 570); // balance + today's spending
      expect(alice['expense'], 9);

      final bob = await asUser('bob', view);
      expect(bob['accounts'], ['Kart', 'Nağd']);
      expect(bob['balance'], 7);
      expect(bob['merchant'], 'other');
      expect(
        [bob['transactions'], bob['rules'], bob['debts']],
        [0, isEmpty, 0],
      );
    },
  );

  test('a user cannot change or remove another user\'s rows by id', () async {
    final rule = await asUser(
      'alice',
      () async => (await env.repos.rules.getAll()).last,
    );
    final debt = await asUser(
      'alice',
      () async => (await env.repos.debts.getAll()).single,
    );
    final account = await asUser(
      'alice',
      () async => (await env.repos.accounts.getAll()).first,
    );

    await asUser('bob', () async {
      await env.repos.rules.setEnabled(rule.id!, enabled: false, day: now);
      await env.repos.rules.delete(rule.id!);
      await env.repos.debts.delete(debt.debt.id!);
      await env.repos.transactions.add(
        Transaction(
          amount: 100,
          type: TxType.expense,
          category: 'cafe',
          accountId: account.id!,
          date: now,
        ),
      );
    });

    await asUser('alice', () async {
      expect((await env.repos.rules.getAll()).every((r) => r.isActive), isTrue);
      expect(await env.repos.debts.getAll(), hasLength(1));
      expect(
        (await env.repos.accounts.getAll()).first.balance,
        account.balance,
      );
    });
  });

  test('the same date can be a day off for two users independently', () async {
    await env.useCases.scheduleEditor.setDayOff(
      DateTime(2026, 10, 22),
      off: true,
    );
    expect((await env.useCases.loadSchedule(from)).offDays, {
      DateTime(2026, 10, 22),
    });
    await env.useCases.scheduleEditor.setDayOff(
      DateTime(2026, 10, 22),
      off: false,
    );
    expect((await env.useCases.loadSchedule(from)).offDays, isEmpty);
    final alice = await asUser('alice', () => env.useCases.loadSchedule(from));
    expect(alice.offDays, {DateTime(2026, 10, 22)});
  });
}
