import 'package:flutter_test/flutter_test.dart';
import '../../support/test_env.dart';
import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/di/app_repositories.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/usecases/create_rule_from_transaction.dart';
import 'package:flux_wallet/features/rules/domain/usecases/load_schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/recurrence_expander.dart';
import 'package:flux_wallet/features/transactions/domain/entities/new_transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_kind.dart';
import 'package:flux_wallet/features/transactions/domain/usecases/add_transaction.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'
    show databaseFactory, databaseFactoryFfi, sqfliteFfiInit;

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final now = DateTime(2026, 10, 20, 14);

  late TestEnv env;
  late AppDatabase db;
  late AppRepositories repos;
  late AddTransaction add;

  setUp(() async {
    env = await openTestEnv(now: now);
    db = env.db;
    repos = env.repos;
    add = AddTransaction(
      repos.transactions,
      CreateRuleFromTransaction(repos.rules, repos.exceptions),
      () => now,
    );
    await repos.onboarding.complete(
      const OnboardingData(cardBalance: 100, cashBalance: 0),
      now,
    );
  });

  tearDown(() => db.close());

  NewTransaction input({
    TransactionKind kind = TransactionKind.expense,
    String category = 'rent',
    DateTime? date,
    Frequency? repeat,
  }) => NewTransaction(
    kind: kind,
    amount: 30,
    category: category,
    accountId: 1,
    date: date ?? now,
    title: 'Kirayə',
    repeat: repeat,
  );

  Future<double> balance() async =>
      (await repos.accounts.getAll()).first.balance;

  test('expense lowers the balance, income raises it', () async {
    await add(input());
    expect(await balance(), 70);
    await add(input(kind: TransactionKind.income, category: 'salary'));
    expect(await balance(), 100);
  });

  test('the screen offers only expense and income; debts live elsewhere', () {
    expect(TransactionKind.values, [
      TransactionKind.expense,
      TransactionKind.income,
    ]);
  });

  test('rejects zero amounts', () {
    final zero = NewTransaction(
      kind: TransactionKind.expense,
      amount: 0,
      category: 'cafe',
      accountId: 1,
      date: now,
      title: 't',
    );
    expect(() => add(zero), throwsArgumentError);
  });

  test(
    'repeat creates a rule whose first occurrence is the recorded transaction',
    () async {
      await add(input(repeat: Frequency.monthly));
      final rule = (await repos.rules.getAll()).single;
      expect(rule.frequency, Frequency.monthly);
      final ctx = await LoadScheduleContext(repos.dayFlags, repos.exceptions)(
        DateTime(2026, 10, 1),
      );
      final dates = const RecurrenceExpander().expand(
        rule,
        DateTime(2026, 10, 1),
        DateTime(2026, 12, 31),
        ctx: ctx,
      );
      expect(dates, [DateTime(2026, 11, 20), DateTime(2026, 12, 20)]);
    },
  );

  test('a backdated transaction is stored on that day', () async {
    await add(input(date: DateTime(2026, 10, 15)));
    final tx = (await repos.transactions.getBetween(
      DateTime(2026, 10, 15),
      DateTime(2026, 10, 16),
    )).single;
    expect(tx.date.day, 15);
  });
}
