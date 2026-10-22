import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/di/app_repositories.dart';
import 'package:flux_wallet/core/di/app_use_cases.dart';
import 'package:flux_wallet/core/session/session_store.dart';
import 'package:flux_wallet/features/auth/data/pbkdf2_password_hasher.dart';
import 'package:flux_wallet/features/auth/domain/usecases/registration_input.dart';
import 'package:flux_wallet/features/settings/domain/repositories/backup_gateway.dart';
import 'package:flux_wallet/features/settings/domain/repositories/reminder_scheduler.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'
    show
        databaseFactory,
        databaseFactoryFfi,
        inMemoryDatabasePath,
        sqfliteFfiInit;

bool _sqliteReady = false;

void _initSqlite() {
  if (_sqliteReady) return;
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  _sqliteReady = true;
}

class NoReminders implements ReminderScheduler {
  @override
  Future<bool> requestPermission() async => true;
  @override
  Future<void> scheduleDaily(int h, int m, String t, String b) async {}
  @override
  Future<void> cancel() async {}
}

/// A database with one registered, signed-in user and all use cases wired.
class TestEnv {
  TestEnv._(this.db, this.session, this.repos, this.useCases, this.userId);

  final AppDatabase db;
  final SessionStore session;
  final AppRepositories repos;
  final AppUseCases useCases;
  String userId;

  /// Registers another account and signs it in; returns its id.
  Future<String> switchTo(String username) async {
    final user = await useCases.registerUser(
      RegistrationInput(
        fullName: 'User $username',
        username: username,
        password: 'secret123',
      ),
    );
    return userId = user.id;
  }

  Future<void> close() => db.close();
}

/// Pass [path] for a file database (two users/devices in one test); the
/// default is a private in-memory one. Hashing uses few iterations (fast).
Future<TestEnv> openTestEnv({
  DateTime? now,
  String? path,
  String username = 'tester',
  BackupGateway? gateway,
}) async {
  _initSqlite();
  final db = AppDatabase(path: path ?? inMemoryDatabasePath);
  final session = SessionStore(db);
  final repos = AppRepositories(db, session);
  final clockValue = now ?? DateTime(2026, 10, 20, 9);
  final useCases = AppUseCases(
    repos,
    session,
    () => clockValue,
    hasher: const Pbkdf2PasswordHasher(iterations: 1000),
    gateway: gateway ?? _NoGateway(),
    reminders: NoReminders(),
  );
  final env = TestEnv._(db, session, repos, useCases, '');
  await env.switchTo(username);
  return env;
}

/// An environment on an existing database file with nobody registered yet.
Future<TestEnv> openLegacyEnv(String path) async {
  _initSqlite();
  final db = AppDatabase(path: path);
  final session = SessionStore(db);
  final repos = AppRepositories(db, session);
  final useCases = AppUseCases(
    repos,
    session,
    () => DateTime(2026, 10, 20, 9),
    hasher: const Pbkdf2PasswordHasher(iterations: 1000),
    gateway: _NoGateway(),
    reminders: NoReminders(),
  );
  return TestEnv._(db, session, repos, useCases, '');
}

class _NoGateway implements BackupGateway {
  @override
  Future<void> shareFile(String fileName, String contents) async {}
  @override
  Future<String?> pickFile() async => null;
}
