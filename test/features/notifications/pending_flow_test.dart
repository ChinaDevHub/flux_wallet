import 'package:flutter_test/flutter_test.dart';
import '../../support/test_env.dart';
import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/di/app_repositories.dart';
import 'package:flux_wallet/core/di/app_use_cases.dart';
import 'package:flux_wallet/features/notifications/domain/entities/raw_notification.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/usecases/load_schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/recurrence_expander.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'
    show databaseFactory, databaseFactoryFfi, sqfliteFfiInit;

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final now = DateTime(2026, 10, 20, 9); // Tuesday

  late TestEnv env;
  late AppDatabase db;
  late AppRepositories repos;
  late AppUseCases useCases;

  RawNotification bolt([DateTime? at]) => RawNotification(
    text: 'Kart +1234: BOLT.EU 4.80 AZN 20.10 08:42 ABB',
    receivedAt: at ?? now,
  );

  setUp(() async {
    env = await openTestEnv(now: now);
    db = env.db;
    repos = env.repos;
    useCases = env.useCases;
    await repos.onboarding.complete(
      const OnboardingData(cardBalance: 100, cashBalance: 0),
      now,
    );
    await repos.rules.add(
      RecurringRule(
        title: 'Avtobus',
        amount: 1,
        category: 'bus',
        frequency: Frequency.weekdays,
        startDate: DateTime(2026, 1, 1),
      ),
    );
  });

  tearDown(() => db.close());

  test('ingest queues a pending item and suggests the taxi category', () async {
    expect(await useCases.ingest(bolt()), isTrue);
    final p = (await repos.pending.getPending()).single;
    expect([p.merchant, p.amount, p.category], ['BOLT.EU', 4.8, 'taxi']);
    expect(p.occurredAt, DateTime(2026, 10, 20, 8, 42));
    expect(
      await repos.transactions.getBetween(DateTime(2026), DateTime(2027)),
      isEmpty,
    );
  });

  test('the same payment is not queued twice (app + sms, retries)', () async {
    await useCases.ingest(bolt());
    expect(await useCases.ingest(bolt()), isFalse);
    final sms = RawNotification(
      text: 'ABB: BOLT.EU 4.80 AZN 20.10 08:44',
      receivedAt: now.add(const Duration(minutes: 3)),
    );
    expect(await useCases.ingest(sms), isFalse);
    expect(await repos.pending.countPending(), 1);
  });

  test('chat messages without an AZN amount are ignored', () async {
    final chat = RawNotification(text: 'Salam!', receivedAt: now);
    expect(await useCases.ingest(chat), isFalse);
  });

  test('the bus fare for that day is offered as replaceable', () async {
    await useCases.ingest(bolt());
    final view = (await useCases.loadPending()).single;
    expect(view.replaceableBus?.title, 'Avtobus');
  });

  test(
    'confirming books the transaction, replaces the bus and learns',
    () async {
      await useCases.ingest(bolt());
      final view = (await useCases.loadPending()).single;
      await useCases.confirmPending(
        view,
        category: 'taxi',
        replaceBus: true,
        remember: true,
      );
      final tx = (await repos.transactions.getBetween(
        DateTime(2026),
        DateTime(2027),
      )).single;
      expect(
        [tx.category, tx.source, tx.note],
        ['taxi', TxSource.notification, 'BOLT.EU'],
      );
      expect(
        (await repos.accounts.getAll()).first.balance,
        closeTo(95.2, 0.001),
      );
      expect(await repos.pending.countPending(), 0);
      // that day's bus fare is gone, other days keep it
      final ctx = await LoadScheduleContext(
        repos.dayFlags,
        repos.exceptions,
        repos.pauses,
      )(DateTime(2026, 10, 20));
      final bus = (await repos.rules.getAll()).single;
      final days = const RecurrenceExpander().expand(
        bus,
        DateTime(2026, 10, 20),
        DateTime(2026, 10, 22),
        ctx: ctx,
      );
      expect(days.map((d) => d.day), [21, 22]);
      // BOLT.EU is now recognised whatever its casing
      expect(await useCases.suggestCategory('bolt.eu'), 'taxi');
    },
  );

  test('a learned merchant beats the built-in hint', () async {
    await repos.merchants.remember('BOLT EU', 'other');
    expect(await useCases.suggestCategory('BOLT.EU'), 'other');
  });

  test('dismissing removes the item without booking anything', () async {
    await useCases.ingest(bolt());
    await useCases.confirmPending.dismiss(
      (await useCases.loadPending()).single,
    );
    expect(await repos.pending.countPending(), 0);
    expect(
      await repos.transactions.getBetween(DateTime(2026), DateTime(2027)),
      isEmpty,
    );
  });
}
