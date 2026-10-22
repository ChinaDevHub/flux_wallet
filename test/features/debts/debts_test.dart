import 'package:flutter_test/flutter_test.dart';
import '../../support/test_env.dart';
import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/di/app_repositories.dart';
import 'package:flux_wallet/core/di/app_use_cases.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debts_overview.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'
    show databaseFactory, databaseFactoryFfi, sqfliteFfiInit;

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final now = DateTime(2026, 10, 20, 9);

  late TestEnv env;
  late AppDatabase db;
  late AppRepositories repos;
  late AppUseCases useCases;

  Debt debt(
    DebtDirection d, {
    double amount = 100,
    DateTime? due,
    String who = 'Kamal',
  }) => Debt(
    person: who,
    amount: amount,
    direction: d,
    createdAt: now,
    dueDate: due,
  );

  Future<void> create(Debt d) => useCases.createDebt(d);

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

  test('a debt I took lowers the daily limit; one I gave does not', () async {
    final base = (await useCases.loadHome()).dailyBudget; // 500 / 9 days
    await create(
      debt(DebtDirection.lent, amount: 200, due: DateTime(2026, 10, 25)),
    );
    expect((await useCases.loadHome()).dailyBudget, base);
    await create(
      debt(DebtDirection.borrowed, amount: 90, due: DateTime(2026, 10, 25)),
    );
    final snapshot = await useCases.loadHome();
    expect(snapshot.limit.obligations, 90);
    expect(snapshot.dailyBudget, 45.55);
    expect(
      snapshot.upcoming.map((p) => p.rule.title),
      contains('Kamal (Borc)'),
    );
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

  test('a debt due after the next income does not touch this cycle', () async {
    await create(debt(DebtDirection.borrowed, due: DateTime(2026, 11, 15)));
    expect((await useCases.loadHome()).limit.obligations, 0);
  });

  test('an overdue debt is due today', () async {
    await create(
      debt(DebtDirection.borrowed, amount: 40, due: DateTime(2026, 10, 1)),
    );
    expect((await useCases.loadHome()).limit.obligations, 40);
  });

  test('a borrowed debt needs a due date and a positive amount', () {
    expect(() => create(debt(DebtDirection.borrowed)), throwsArgumentError);
    expect(
      () => create(debt(DebtDirection.lent, amount: 0)),
      throwsArgumentError,
    );
  });

  test(
    'partial payments: expense, balance, remaining, progress, closing',
    () async {
      await create(debt(DebtDirection.borrowed, due: DateTime(2026, 10, 25)));
      var s = (await repos.debts.getAll()).single;
      await useCases.recordDebtPayment(s, 30, 1);
      s = (await repos.debts.getAll()).single;
      expect(
        [s.paid, s.remaining, s.progress, s.debt.isClosed],
        [30, 70, 0.3, false],
      );
      expect((await repos.accounts.getAll()).first.balance, 470);
      final tx = (await repos.transactions.getBetween(
        DateTime(2026),
        DateTime(2027),
      )).single;
      expect(
        [tx.type, tx.category, tx.note],
        [TxType.expense, 'debt', 'Kamal'],
      );
      // the obligation shrinks with what is left
      expect((await useCases.loadHome()).limit.obligations, 70);
      await useCases.recordDebtPayment(s, 70, 1);
      s = (await repos.debts.getAll()).single;
      expect([s.isSettled, s.debt.isClosed], [true, true]);
      expect((await useCases.loadHome()).limit.obligations, 0);
    },
  );

  test('getting money back is income and cannot exceed what is owed', () async {
    await create(debt(DebtDirection.lent, amount: 50));
    final s = (await repos.debts.getAll()).single;
    expect(() => useCases.recordDebtPayment(s, 60, 1), throwsArgumentError);
    await useCases.recordDebtPayment(s, 20, 1);
    final tx = (await repos.transactions.getBetween(
      DateTime(2026),
      DateTime(2027),
    )).single;
    expect([tx.type, tx.category], [TxType.income, 'repayment']);
    expect((await repos.accounts.getAll()).first.balance, 520);
  });

  test('overview totals and ordering; deleting cascades payments', () async {
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
    final b = overview.all.firstWhere((s) => s.debt.person == 'B');
    await useCases.recordDebtPayment(b, 10, 1);
    await repos.debts.delete(b.debt.id!);
    expect((await repos.debts.getAll()).map((s) => s.debt.person), ['A', 'C']);
  });
}
