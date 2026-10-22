import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/di/app_repositories.dart';
import 'package:flux_wallet/core/di/app_use_cases.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debts_overview.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import '../../support/test_env.dart';

void main() {
  final now = DateTime(2026, 10, 20, 9); // Tuesday; next salary on the 29th

  late TestEnv env;
  late AppDatabase db;
  late AppRepositories repos;
  late AppUseCases useCases;

  Debt debt(
    DebtDirection d, {
    double amount = 100,
    DateTime? due,
    DateTime? date,
    String who = 'Kamal',
  }) => Debt(
    person: who,
    amount: amount,
    direction: d,
    createdAt: date ?? now,
    dueDate: due,
  );

  Future<void> create(Debt d, {int account = 1}) =>
      useCases.createDebt(d, accountId: account);

  Future<double> card() async => (await repos.accounts.getAll()).first.balance;

  Future<List<Transaction>> allTx() =>
      repos.transactions.getBetween(DateTime(2026), DateTime(2027));

  setUp(() async {
    env = await openTestEnv(now: now);
    db = env.db;
    repos = env.repos;
    useCases = env.useCases;
    await repos.onboarding.complete(
      const OnboardingData(
        cardBalance: 500,
        cashBalance: 0,
        salaryAmount: 1000,
        salaryDay: 29,
      ),
      now,
    );
  });

  tearDown(() => db.close());

  group('creating a debt moves the money', () {
    test('borrowing puts it into the account, linked to the debt', () async {
      await create(
        debt(DebtDirection.borrowed, amount: 30, due: DateTime(2026, 10, 25)),
      );
      expect(await card(), 530);
      final tx = (await allTx()).single;
      expect(
        [tx.type, tx.category, tx.note, tx.amount],
        [TxType.income, 'debt', 'Kamal', 30],
      );
      expect(tx.debtId, (await repos.debts.getAll()).single.debt.id);
    });

    test('lending takes it out of the account', () async {
      await create(debt(DebtDirection.lent, amount: 20, who: 'Fuad'));
      expect(await card(), 480);
      final tx = (await allTx()).single;
      expect([tx.type, tx.category, tx.note], [TxType.expense, 'debt', 'Fuad']);
    });

    test('the other account can be used', () async {
      await create(debt(DebtDirection.lent, amount: 20), account: 2);
      expect(
        [for (final a in await repos.accounts.getAll()) a.balance],
        [500, -20],
      );
    });

    test('the two together: +30 and -20, as the user would expect', () async {
      await create(
        debt(
          DebtDirection.borrowed,
          amount: 30,
          who: 'Cuma',
          due: DateTime(2026, 10, 25),
        ),
      );
      await create(debt(DebtDirection.lent, amount: 20, who: 'Fuad'));
      expect(await card(), 510);
      final overview = DebtsOverview(await repos.debts.getAll());
      expect(overview.total(DebtDirection.borrowed), 30);
      expect(overview.total(DebtDirection.lent), 20);
    });
  });

  group('dating a debt', () {
    test('yesterday: the movement is yesterday\'s, not today\'s', () async {
      final yesterday = DateTime(2026, 10, 19);
      await create(
        debt(
          DebtDirection.borrowed,
          amount: 30,
          date: yesterday,
          due: DateTime(2026, 10, 25),
        ),
      );
      final tx = (await allTx()).single;
      expect(tx.date, DateTime(2026, 10, 19, 12));
      final home = await useCases.loadHome();
      expect(home.todayTransactions, isEmpty);
      expect(home.spentToday, 0);
      expect(await card(), 530);
      expect((await repos.debts.getAll()).single.debt.createdAt, tx.date);
    });

    test('a debt dated today keeps the real time', () async {
      await create(debt(DebtDirection.lent, amount: 5));
      expect((await allTx()).single.date, now);
    });

    test('the future and an impossible due date are refused', () {
      expect(
        () => create(debt(DebtDirection.lent, date: DateTime(2026, 10, 21))),
        throwsArgumentError,
      );
      expect(
        () => create(
          debt(
            DebtDirection.borrowed,
            date: DateTime(2026, 10, 19),
            due: DateTime(2026, 10, 18),
          ),
        ),
        throwsArgumentError,
      );
    });
  });

  group('the daily limit', () {
    test('borrowing due this pay period nets out: no extra to spend', () async {
      final base = (await useCases.loadHome()).dailyBudget; // 500 / 9 days
      await create(
        debt(DebtDirection.borrowed, amount: 90, due: DateTime(2026, 10, 25)),
      );
      final home = await useCases.loadHome();
      expect(home.limit.obligations, 90);
      expect(home.limit.totalBalance, 590);
      expect(home.dailyBudget, base);
      expect(home.upcoming.map((p) => p.rule.title), contains('Kamal (Borc)'));
    });

    test('lending lowers what is free: the money is gone', () async {
      await create(debt(DebtDirection.lent, amount: 200));
      final home = await useCases.loadHome();
      expect(home.limit.obligations, 0);
      expect(home.limit.totalBalance, 300);
      expect(home.dailyBudget, 33.33);
      expect(home.spentToday, 0);
    });

    test('borrowing due after the next salary is spendable now', () async {
      await create(debt(DebtDirection.borrowed, due: DateTime(2026, 11, 15)));
      final home = await useCases.loadHome();
      expect(home.limit.obligations, 0);
      expect(home.limit.totalBalance, 600);
    });

    test('an overdue debt is due today', () async {
      await create(
        debt(
          DebtDirection.borrowed,
          amount: 40,
          date: DateTime(2026, 10, 1),
          due: DateTime(2026, 10, 10),
        ),
      );
      expect((await useCases.loadHome()).limit.obligations, 40);
    });

    test('paying a debt neither uses up nor inflates today\'s limit', () async {
      await create(
        debt(DebtDirection.borrowed, amount: 90, due: DateTime(2026, 10, 25)),
      );
      final before = await useCases.loadHome();
      await useCases.recordDebtPayment(
        (await repos.debts.getAll()).single,
        90,
        1,
      );
      final after = await useCases.loadHome();
      expect(after.dailyBudget, before.dailyBudget);
      expect(after.remainingToday, before.remainingToday);
      expect(after.spentToday, 0);
    });
  });

  test('a borrowed debt needs a due date and a positive amount', () {
    expect(() => create(debt(DebtDirection.borrowed)), throwsArgumentError);
    expect(
      () => create(debt(DebtDirection.lent, amount: 0)),
      throwsArgumentError,
    );
  });

  test('partial payments: expense, balance, remaining, closing', () async {
    await create(debt(DebtDirection.borrowed, due: DateTime(2026, 10, 25)));
    var s = (await repos.debts.getAll()).single;
    await useCases.recordDebtPayment(s, 30, 1);
    s = (await repos.debts.getAll()).single;
    expect(
      [s.paid, s.remaining, s.progress, s.debt.isClosed],
      [30, 70, 0.3, false],
    );
    expect(await card(), 570); // 500 + 100 borrowed - 30 paid
    final pay = (await allTx()).firstWhere((t) => t.type == TxType.expense);
    expect([pay.category, pay.note, pay.debtId], ['debt', 'Kamal', s.debt.id]);
    expect((await useCases.loadHome()).limit.obligations, 70);
    await useCases.recordDebtPayment(s, 70, 1);
    s = (await repos.debts.getAll()).single;
    expect([s.isSettled, s.debt.isClosed], [true, true]);
    expect(await card(), 500);
    expect((await useCases.loadHome()).limit.obligations, 0);
  });

  test('getting money back is income and cannot exceed what is owed', () async {
    await create(debt(DebtDirection.lent, amount: 50));
    final s = (await repos.debts.getAll()).single;
    expect(() => useCases.recordDebtPayment(s, 60, 1), throwsArgumentError);
    await useCases.recordDebtPayment(s, 20, 1);
    final back = (await allTx()).firstWhere((t) => t.type == TxType.income);
    expect([back.category, back.debtId], ['repayment', s.debt.id]);
    expect(await card(), 470); // 500 - 50 lent + 20 back
  });

  group('deleting a debt gives everything back', () {
    test('borrowed with a partial payment', () async {
      await create(debt(DebtDirection.borrowed, due: DateTime(2026, 10, 25)));
      final s = (await repos.debts.getAll()).single;
      await useCases.recordDebtPayment(s, 30, 1);
      await repos.debts.delete(s.debt.id!);
      expect(await card(), 500);
      expect(await allTx(), isEmpty);
      expect(await repos.debts.getAll(), isEmpty);
    });

    test('lent and repaid in part, on the other account', () async {
      await create(debt(DebtDirection.lent, amount: 50), account: 2);
      final s = (await repos.debts.getAll()).single;
      await useCases.recordDebtPayment(s, 20, 2);
      await repos.debts.delete(s.debt.id!);
      expect(
        [for (final a in await repos.accounts.getAll()) a.balance],
        [500, 0],
      );
    });

    test('other money and other debts are left alone', () async {
      await repos.transactions.add(
        Transaction(
          amount: 12,
          type: TxType.expense,
          category: 'cafe',
          accountId: 1,
          date: now,
        ),
      );
      await create(debt(DebtDirection.lent, amount: 20, who: 'A'));
      await create(debt(DebtDirection.lent, amount: 30, who: 'B'));
      final a = (await repos.debts.getAll()).firstWhere(
        (s) => s.debt.person == 'A',
      );
      await repos.debts.delete(a.debt.id!);
      expect(await card(), 458); // 500 - 12 - 30
      expect((await allTx()).length, 2);
    });
  });

  test('debts are not spending or earning in the statistics', () async {
    await create(debt(DebtDirection.lent, amount: 20));
    await create(debt(DebtDirection.borrowed, due: DateTime(2026, 10, 25)));
    final stats = await useCases.loadStatistics();
    expect(stats.months.last.expense, 0);
    expect(stats.months.last.income, 0);
    expect(stats.shares, isEmpty);
  });

  test('overview totals and ordering', () async {
    await create(
      debt(DebtDirection.borrowed, who: 'A', due: DateTime(2026, 10, 30)),
    );
    await create(
      debt(
        DebtDirection.borrowed,
        who: 'B',
        amount: 50,
        due: DateTime(2026, 10, 22),
      ),
    );
    await create(debt(DebtDirection.lent, who: 'C', amount: 80));
    final overview = DebtsOverview(await repos.debts.getAll());
    expect(overview.open(DebtDirection.borrowed).map((s) => s.debt.person), [
      'B',
      'A',
    ]);
    expect(overview.total(DebtDirection.borrowed), 150);
    expect(overview.total(DebtDirection.lent), 80);
  });
}
