import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/features/home/data/repositories/account_repository_impl.dart';
import 'package:flux_wallet/features/home/data/repositories/day_flag_repository_impl.dart';
import 'package:flux_wallet/features/home/data/repositories/recurring_rule_repository_impl.dart';
import 'package:flux_wallet/features/home/data/repositories/transaction_repository_impl.dart';
import 'package:flux_wallet/features/home/domain/entities/daily_tip.dart';
import 'package:flux_wallet/features/home/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/home/domain/entities/transaction.dart';
import 'package:flux_wallet/features/home/domain/usecases/load_home_snapshot.dart';
import 'package:flux_wallet/features/onboarding/data/profile_repository_impl.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'
    show
        databaseFactory,
        databaseFactoryFfi,
        inMemoryDatabasePath,
        sqfliteFfiInit;

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final now = DateTime(2026, 10, 20, 14);

  late AppDatabase db;
  late LoadHomeSnapshot load;
  late TransactionRepositoryImpl transactions;
  late RecurringRuleRepositoryImpl rules;
  late ProfileRepositoryImpl profile;

  setUp(() async {
    db = AppDatabase(path: inMemoryDatabasePath);
    transactions = TransactionRepositoryImpl(db);
    rules = RecurringRuleRepositoryImpl(db);
    profile = ProfileRepositoryImpl(db);
    load = LoadHomeSnapshot(
      profile: profile,
      accounts: AccountRepositoryImpl(db),
      transactions: transactions,
      rules: rules,
      dayFlags: DayFlagRepositoryImpl(db),
      clock: () => now,
    );
    await profile.completeOnboarding(
      const OnboardingData(
        name: 'Rauf',
        cardBalance: 400,
        cashBalance: 100,
        salaryAmount: 1200,
        salaryDay: 29,
      ),
      now,
    );
  });

  tearDown(() => db.close());

  test('onboarding is detected and the limit is derived from the DB', () async {
    expect(await profile.readName(), 'Rauf');
    final s = await load();
    expect(s.limit.totalBalance, 500);
    expect(s.limit.daysLeft, 9);
    expect(s.dailyBudget, 55.55);
    expect(s.remainingToday, 55.55);
    expect(s.tip.kind, TipKind.saving);
  });

  test('spending today lowers remaining but keeps the daily budget', () async {
    await transactions.add(
      Transaction(
        amount: 10,
        type: TxType.expense,
        category: 'cafe',
        accountId: 1,
        date: now,
      ),
    );
    final s = await load();
    expect(s.dailyBudget, 55.55);
    expect(s.spentToday, 10);
    expect(s.remainingToday, 45.55);
    expect(s.limit.totalBalance, 500); // 490 balance + 10 added back
  });

  test('upcoming lists monthly payments and income inside 14 days', () async {
    await rules.add(
      RecurringRule(
        title: 'Kirayə',
        amount: 250,
        category: 'rent',
        frequency: Frequency.monthly,
        startDate: DateTime(2026, 8, 25),
      ),
    );
    final s = await load();
    expect(s.upcoming.map((p) => p.rule.title), ['Kirayə', 'Maaş']);
    expect(s.limit.obligations, 250);
  });

  test('shortfall produces the shortfall tip', () async {
    await rules.add(
      RecurringRule(
        title: 'Kirayə',
        amount: 900,
        category: 'rent',
        frequency: Frequency.monthly,
        startDate: DateTime(2026, 8, 25),
      ),
    );
    final s = await load();
    expect(s.limit.shortfall, 400);
    expect(s.tip, const DailyTip(TipKind.shortfall, 400));
  });
}
