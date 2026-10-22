import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_migrations.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/features/auth/domain/usecases/registration_input.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../support/test_env.dart';

/// A database exactly as the single-user app (schema v3) left it.
Future<String> createV3Database(Directory dir) async {
  final path = '${dir.path}/legacy.db';
  final db = await databaseFactory.openDatabase(
    path,
    options: OpenDatabaseOptions(
      version: 3,
      onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
      onCreate: (db, _) async {
        for (var v = 1; v <= 3; v++) {
          for (final sql in migrations[v]!) {
            await db.execute(sql);
          }
        }
        await db.insert('accounts', {
          'name': 'Kart',
          'balance': 100.0,
          'type': 'card',
        });
        await db.insert('recurring_rules', {
          'title': 'Kirayə',
          'amount': 250.0,
          'category': 'rent',
          'type': 'expense',
          'frequency': 'monthly',
          'start_date': '2026-08-25',
        });
        await db.insert('transactions', {
          'amount': 5.0,
          'type': 'expense',
          'category': 'cafe',
          'account_id': 1,
          'date': '2026-10-20T10:00:00.000',
          'source': 'manual',
        });
        await db.insert('day_flags', {
          'date': '2026-10-21',
          'is_not_working_day': 1,
        });
        await db.insert('rule_exceptions', {
          'rule_id': 1,
          'date': '2026-10-22',
        });
        await db.insert('merchant_mappings', {
          'merchant_key': 'BOLT EU',
          'category': 'taxi',
        });
        await db.insert('pending_notifications', {
          'fingerprint': 'f1',
          'raw_text': 'raw',
          'merchant': 'BOLT.EU',
          'amount': 4.8,
          'type': 'expense',
          'occurred_at': '2026-10-20T08:42:00.000',
          'status': 'pending',
        });
        await db.insert('debts', {
          'person': 'Kamal',
          'amount': 50.0,
          'direction': 'borrowed',
          'created_at': '2026-10-01T00:00:00.000',
        });
        await db.insert('debt_payments', {
          'debt_id': 1,
          'amount': 10.0,
          'date': '2026-10-02T00:00:00.000',
        });
        await db.insert('settings', {'key': 'user_name', 'value': 'Rauf'});
      },
    ),
  );
  await db.close();
  return path;
}

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  late Directory dir;

  setUp(() => dir = Directory.systemTemp.createTempSync('flux_mig_'));
  tearDown(() => dir.deleteSync(recursive: true));

  test('a v3 database upgrades to v4 and keeps every row', () async {
    final app = AppDatabase(path: await createV3Database(dir));
    final db = await app.instance;
    expect(await db.query(Tables.users), isEmpty);
    for (final t in [
      'accounts',
      'recurring_rules',
      'transactions',
      'day_flags',
      'rule_exceptions',
      'merchant_mappings',
      'pending_notifications',
      'debts',
      'debt_payments',
    ]) {
      final rows = await db.query(t);
      expect(rows, hasLength(1), reason: t);
      expect(rows.single.containsKey('user_id'), isTrue, reason: t);
      expect(
        rows.single['user_id'],
        isNull,
        reason: 'legacy $t has no owner yet',
      );
    }
    expect(
      (await db.query('merchant_mappings')).single['merchant_key'],
      'BOLT EU',
    );
    // v5: transactions can belong to a debt; old ones belong to none
    expect((await db.query('transactions')).single['debt_id'], isNull);
    await app.close();
  });

  test(
    'the first account to register adopts the old data, later ones do not',
    () async {
      final env = await openLegacyEnv(await createV3Database(dir));
      final first = await env.useCases.registerUser(
        const RegistrationInput(
          fullName: 'Rauf',
          username: 'rauf',
          password: 'secret123',
        ),
      );
      expect((await env.repos.accounts.getAll()).single.balance, 100);
      expect((await env.repos.rules.getAll()).single.title, 'Kirayə');
      expect(
        await env.repos.transactions.getBetween(DateTime(2026), DateTime(2027)),
        hasLength(1),
      );
      expect(await env.repos.pending.countPending(), 1);
      expect(await env.repos.merchants.categoryFor('BOLT EU'), 'taxi');
      expect((await env.repos.debts.getAll()).single.paid, 10);
      expect((await env.useCases.loadSchedule(DateTime(2026))).offDays, {
        DateTime(2026, 10, 21),
      });
      expect(await env.useCases.resolveSession(), isNotNull);
      expect(first.id, env.session.activeId);

      await env.useCases.registerUser(
        const RegistrationInput(
          fullName: 'Aysel',
          username: 'aysel',
          password: 'secret123',
        ),
      );
      expect(await env.repos.accounts.getAll(), isEmpty);
      expect(await env.repos.debts.getAll(), isEmpty);
      await env.close();
    },
  );

  test('a fresh install creates the latest schema directly', () async {
    final app = AppDatabase(path: '${dir.path}/fresh.db');
    final db = await app.instance;
    expect(await db.query(Tables.users), isEmpty);
    await db.insert(Tables.users, {
      'id': 'u1',
      'username': 'a',
      'password_hash': 'h',
      'full_name': 'A',
      'created_at': '2026-10-20T00:00:00.000',
    });
    await db.insert(Tables.accounts, {
      'user_id': 'u1',
      'name': 'Kart',
      'balance': 1.0,
      'type': 'card',
    });
    // two users may flag the same date; one user may not do it twice
    await db.insert(Tables.users, {
      'id': 'u2',
      'username': 'b',
      'password_hash': 'h',
      'full_name': 'B',
      'created_at': '2026-10-20T00:00:00.000',
    });
    await db.insert(Tables.dayFlags, {
      'user_id': 'u1',
      'date': '2026-10-21',
      'is_not_working_day': 1,
    });
    await db.insert(Tables.dayFlags, {
      'user_id': 'u2',
      'date': '2026-10-21',
      'is_not_working_day': 1,
    });
    await expectLater(
      db.insert(Tables.dayFlags, {
        'user_id': 'u1',
        'date': '2026-10-21',
        'is_not_working_day': 0,
      }),
      throwsA(isA<DatabaseException>()),
    );
    await expectLater(
      db.insert(Tables.users, {
        'id': 'u3',
        'username': 'a',
        'password_hash': 'h',
        'full_name': 'dup',
        'created_at': '2026-10-20T00:00:00.000',
      }),
      throwsA(isA<DatabaseException>()),
    );
    await app.close();
  });
}
