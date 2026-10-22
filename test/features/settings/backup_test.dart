import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/notifications/domain/entities/raw_notification.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/settings/domain/entities/backup_exception.dart';
import 'package:flux_wallet/features/settings/domain/repositories/backup_gateway.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import '../../support/test_env.dart';

class _FakeGateway implements BackupGateway {
  String? sharedName, sharedText, toPick;

  @override
  Future<void> shareFile(String fileName, String contents) async {
    sharedName = fileName;
    sharedText = contents;
  }

  @override
  Future<String?> pickFile() async => toPick;
}

void main() {
  final now = DateTime(2026, 10, 20, 9);

  late Directory tempDir;
  late _FakeGateway gateway;
  late TestEnv source, target;

  /// What a user "has", without ids (which are renumbered on import).
  Future<Map<String, List<Object?>>> content(TestEnv e) async {
    final txs = await e.repos.transactions.getBetween(
      DateTime(2026),
      DateTime(2027),
    );
    return {
      'accounts': [
        for (final a in await e.repos.accounts.getAll())
          '${a.name}:${a.balance}',
      ],
      'rules': [
        for (final r in await e.repos.rules.getAll()) '${r.title}:${r.amount}',
      ],
      'transactions': [for (final t in txs) '${t.note}:${t.signedAmount}'],
      'debts': [
        for (final d in await e.repos.debts.getAll())
          '${d.debt.person}:${d.paid}:${d.debt.isClosed}',
      ],
      'pending': [
        for (final p in await e.repos.pending.getPending()) p.merchant,
      ],
      'remembered': [await e.repos.merchants.categoryFor('BOLT EU')],
    };
  }

  setUp(() async {
    gateway = _FakeGateway();
    tempDir = Directory.systemTemp.createTempSync('flux_backup_');
    source = await openTestEnv(
      now: now,
      path: '${tempDir.path}/source.db',
      gateway: gateway,
    );
    target = await openTestEnv(
      now: now,
      path: '${tempDir.path}/target.db',
      gateway: gateway,
      username: 'other',
    );
    final u = source.useCases, r = source.repos;
    await r.onboarding.complete(
      const OnboardingData(
        cardBalance: 400,
        cashBalance: 50,
        salaryAmount: 1200,
        salaryDay: 29,
      ),
      now,
    );
    final ruleId = await r.rules.add(
      RecurringRule(
        title: 'Avtobus',
        amount: 1,
        category: 'bus',
        frequency: Frequency.weekdays,
        startDate: DateTime(2026, 1, 1),
      ),
    );
    await u.scheduleEditor.skipOnce(
      (await r.rules.getAll()).firstWhere((x) => x.id == ruleId),
      DateTime(2026, 10, 21),
    );
    await r.transactions.add(
      Transaction(
        amount: 4.8,
        type: TxType.expense,
        category: 'taxi',
        accountId: (await r.accounts.getAll()).first.id!,
        date: now,
        note: 'Bolt',
      ),
    );
    await u.createDebt(
      Debt(
        person: 'Kamal',
        amount: 100,
        direction: DebtDirection.borrowed,
        createdAt: now,
        dueDate: DateTime(2026, 10, 25),
      ),
    );
    await u.recordDebtPayment(
      (await r.debts.getAll()).single,
      30,
      (await r.accounts.getAll()).first.id!,
    );
    await u.ingest(
      RawNotification(
        text: 'Kart +1234: BOLT.EU 5.00 AZN 20.10 08:00',
        receivedAt: now,
      ),
    );
    await r.merchants.remember('BOLT EU', 'taxi');
  });

  tearDown(() async {
    await source.close();
    await target.close();
    tempDir.deleteSync(recursive: true);
  });

  test('export then import into another account restores everything', () async {
    await source.useCases.exportBackup();
    expect(gateway.sharedName, 'flux_wallet_20261020.json');
    gateway.toPick = gateway.sharedText;
    expect(await target.useCases.importBackup(), isTrue);
    expect(await content(target), await content(source));
  });

  test(
    'the file holds only the signed-in user\'s data, without user ids',
    () async {
      await target.repos.onboarding.complete(
        const OnboardingData(cardBalance: 1, cashBalance: 1),
        now,
      );
      await source.useCases.exportBackup();
      final data = jsonDecode(gateway.sharedText!) as Map;
      final accounts = (data['tables'] as Map)['accounts'] as List;
      expect(accounts, hasLength(2));
      expect(gateway.sharedText, isNot(contains('user_id')));
      expect(data['tables'], isNot(contains('users')));
      expect(data['tables'], isNot(contains('settings')));
    },
  );

  test('importing replaces only the importing user\'s data', () async {
    await target.repos.onboarding.complete(
      const OnboardingData(cardBalance: 7, cashBalance: 0),
      now,
    );
    final sourceBefore = await content(source);
    await source.useCases.exportBackup();
    gateway.toPick = gateway.sharedText;
    await target.useCases.importBackup();
    expect((await target.repos.accounts.getAll()).map((a) => a.balance), [
      365.2,
      50,
    ]);
    expect(await content(source), sourceBefore);
  });

  test('ids are renumbered, so two users can restore the same file', () async {
    await source.useCases.exportBackup();
    gateway.toPick = gateway.sharedText;
    await target.useCases.importBackup();
    // a second import into the first database must not collide with its ids
    await source.useCases.importBackup();
    expect(await content(source), await content(target));
    final tables = Tables.userData.length;
    expect(tables, greaterThan(5));
  });

  test('cancelling the picker changes nothing', () async {
    gateway.toPick = null;
    expect(await target.useCases.importBackup(), isFalse);
    expect(await target.repos.accounts.getAll(), isEmpty);
  });

  test('invalid files are rejected and the data stays', () async {
    final before = await content(source);
    for (final bad in [
      'not json',
      '{"app":"other","tables":{}}',
      '{"app":"flux_wallet","schema":99,"tables":{}}',
      jsonEncode({'hello': 'world'}),
    ]) {
      gateway.toPick = bad;
      await expectLater(
        source.useCases.importBackup(),
        throwsA(isA<BackupException>()),
      );
    }
    expect(await content(source), before);
  });

  test('a backup of an older schema (missing tables) still imports', () async {
    gateway.toPick = jsonEncode({
      'app': 'flux_wallet',
      'schema': 1,
      'tables': {
        'accounts': [
          {'id': 1, 'name': 'Kart', 'balance': 10.0, 'type': 'card'},
        ],
        'settings': [
          {'key': 'user_name', 'value': 'Old'},
        ],
      },
    });
    await target.useCases.importBackup();
    expect((await target.repos.accounts.getAll()).single.balance, 10);
    expect(await target.repos.debts.getAll(), isEmpty);
  });
}
