import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import '../../support/new_transaction_builder.dart';
import '../../support/test_env.dart';

void main() {
  final now = DateTime(2026, 10, 20, 14);
  late TestEnv env;

  setUp(() async {
    env = await openTestEnv(now: now);
    await env.repos.onboarding.complete(
      const OnboardingData(cardBalance: 100, cashBalance: 50),
      now,
    );
  });
  tearDown(() => env.close());

  Future<List<double>> balances() async =>
      (await env.repos.accounts.getAll()).map((a) => a.balance).toList();

  Future<Transaction> only() async => (await env.repos.transactions.getBetween(
    DateTime(2026),
    DateTime(2027),
  )).single;

  test('editing moves the money between accounts and keeps the time', () async {
    await env.repos.transactions.add(
      Transaction(
        amount: 10,
        type: TxType.expense,
        category: 'cafe',
        accountId: 1,
        date: now,
      ),
    );
    final old = await only();
    await env.useCases.changeTransaction.update(
      old,
      Transaction(
        amount: 25,
        type: TxType.expense,
        category: 'taxi',
        accountId: 2,
        date: now,
      ),
    );
    expect(await balances(), [100, 25]);
    final edited = await only();
    expect([edited.amount, edited.category, edited.accountId], [25, 'taxi', 2]);
    expect(edited.date, now);
  });

  test('removing gives the money back', () async {
    await env.repos.transactions.add(
      Transaction(
        amount: 10,
        type: TxType.expense,
        category: 'cafe',
        accountId: 1,
        date: now,
      ),
    );
    await env.useCases.changeTransaction.remove(await only());
    expect(await balances(), [100, 50]);
  });

  test('money that belongs to a debt is not editable here', () async {
    await env.useCases.createDebt(
      Debt(
        person: 'Kamal',
        amount: 30,
        direction: DebtDirection.borrowed,
        createdAt: now,
        dueDate: now,
      ),
      accountId: 1,
    );
    final opening = await only();
    expect(
      () => env.useCases.changeTransaction.remove(opening),
      throwsArgumentError,
    );
  });

  test('a later date is saved as a plan, not a transaction', () async {
    await env.useCases.addTransaction(
      NewTransactionBuilder.plan(DateTime(2026, 10, 25), 50),
    );
    expect(
      await env.repos.transactions.getBetween(DateTime(2026), DateTime(2027)),
      isEmpty,
    );
    final rule = (await env.repos.rules.getAll()).single;
    expect(rule.startDate, DateTime(2026, 10, 25));
    expect(rule.endDate, DateTime(2026, 10, 25));
    final view = await env.useCases.loadTimeline(DateTime(2026, 10));
    final day = view.days.firstWhere((d) => d.date.day == 25);
    expect(day.entries.single.signedAmount, -50);
  });
}
