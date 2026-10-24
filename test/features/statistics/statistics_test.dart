import 'package:flutter_test/flutter_test.dart';
import '../../support/test_env.dart';
import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/di/app_repositories.dart';
import 'package:flux_wallet/core/di/app_use_cases.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:flux_wallet/features/statistics/domain/entities/stats_range.dart';
import 'package:flux_wallet/features/statistics/domain/usecases/slider_months.dart';
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

  Future<void> add(
    double amount,
    String category,
    DateTime date, {
    TxType type = TxType.expense,
  }) => repos.transactions.add(
    Transaction(
      amount: amount,
      type: type,
      category: category,
      accountId: 1,
      date: date,
    ),
  );

  setUp(() async {
    env = await openTestEnv(now: now);
    db = env.db;
    repos = env.repos;
    useCases = env.useCases;
    await repos.onboarding.complete(
      const OnboardingData(cardBalance: 1000, cashBalance: 0),
      now,
    );
  });

  tearDown(() => db.close());

  test('six months ending with the current one, income vs expense', () async {
    await add(1000, 'salary', DateTime(2026, 10, 5), type: TxType.income);
    await add(300, 'grocery', DateTime(2026, 10, 6));
    await add(200, 'rent', DateTime(2026, 9, 25));
    await add(800, 'salary', DateTime(2026, 9, 1), type: TxType.income);
    final view = await useCases.loadStatistics();
    expect(view.months.map((m) => m.month.month), [5, 6, 7, 8, 9, 10]);
    final oct = view.months.last;
    expect([oct.income, oct.expense, oct.net], [1000, 300, 700]);
    final sep = view.months[4];
    expect([sep.income, sep.expense], [800, 200]);
    expect(view.months.first.expense, 0);
  });

  test('category shares add up to 100 and are sorted', () async {
    await add(330, 'grocery', DateTime(2026, 10, 2));
    await add(250, 'rent', DateTime(2026, 10, 3));
    await add(210, 'cafe', DateTime(2026, 10, 4));
    await add(210, 'taxi', DateTime(2026, 10, 5));
    final shares = (await useCases.loadStatistics()).shares;
    expect(shares.map((s) => s.category), ['grocery', 'rent', 'cafe', 'taxi']);
    expect(shares.first.percent, closeTo(33, 0.001));
    expect(shares.fold(0.0, (s, e) => s + e.percent), closeTo(100, 0.001));
  });

  test('small categories fold into other; income never counts', () async {
    for (final c in [
      'grocery',
      'rent',
      'cafe',
      'taxi',
      'bus',
      'fuel',
      'gift',
    ]) {
      await add(10, c, DateTime(2026, 10, 2));
    }
    await add(5000, 'salary', DateTime(2026, 10, 2), type: TxType.income);
    final shares = (await useCases.loadStatistics()).shares;
    expect(shares, hasLength(6));
    expect(shares.last.category, 'other');
    expect(shares.last.amount, 20);
  });

  test('one month can be picked; an empty month has no shares', () async {
    await add(100, 'rent', DateTime(2026, 9, 25));
    final sep = await useCases.loadStatistics(month: DateTime(2026, 9, 14));
    expect(sep.selected, DateTime(2026, 9));
    expect(sep.shares.single.category, 'rent');
    expect(sep.selectedTotals.expense, 100);
    final oct = await useCases.loadStatistics(month: DateTime(2026, 10));
    expect(oct.shares, isEmpty);
  });

  test('a range covers just its months; the whole range is summed', () async {
    await add(100, 'rent', DateTime(2026, 9, 25));
    await add(40, 'cafe', DateTime(2026, 10, 2));
    await add(70, 'taxi', DateTime(2026, 7, 2));
    final range = StatsRange(DateTime(2026, 8), DateTime(2026, 10));
    final view = await useCases.loadStatistics(range: range);
    expect(view.months.map((m) => m.month.month), [8, 9, 10]);
    expect(view.selected, isNull);
    expect(view.selectedTotals.expense, 140);
    expect(view.shares.map((s) => s.category), ['rent', 'cafe']);
    expect(range.presetAt(now), StatsPreset.three);
    expect(StatsRange.last(2, now).presetAt(now), StatsPreset.two);
  });

  test('the slider reaches back to the first data, at least six months', () {
    final today = DateTime(2026, 10, 20);
    expect(sliderMonths(null, today), hasLength(6));
    expect(sliderMonths(DateTime(2025, 1, 5), today).first, DateTime(2025));
    expect(sliderMonths(DateTime(2020), today), hasLength(24));
  });
}
