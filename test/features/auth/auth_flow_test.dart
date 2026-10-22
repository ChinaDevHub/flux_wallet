import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/session/session_store.dart';
import 'package:flux_wallet/features/auth/domain/entities/auth_exception.dart';
import 'package:flux_wallet/features/auth/domain/usecases/registration_input.dart';
import 'package:flux_wallet/features/auth/domain/usecases/resolve_session.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import '../../support/test_env.dart';

void main() {
  late TestEnv env;
  final now = DateTime(2026, 10, 20, 9);

  Future<AuthFailure?> failureOf(Future<Object?> Function() action) async {
    try {
      await action();
    } on AuthException catch (e) {
      return e.failure;
    }
    return null;
  }

  RegistrationInput input({
    String name = 'Rauf Əliyev',
    String username = 'rauf',
    String password = 'secret123',
    String hint = '',
  }) => RegistrationInput(
    fullName: name,
    username: username,
    password: password,
    hint: hint,
  );

  setUp(() async => env = await openTestEnv(now: now));
  tearDown(() => env.close());

  group('registration', () {
    test('stores a hash, never the password, and signs the user in', () async {
      final user = await env.useCases.registerUser(input(hint: 'it is my cat'));
      expect(user.passwordHash, isNot(contains('secret123')));
      expect(user.passwordHash, startsWith('pbkdf2-sha256\$'));
      expect(user.passwordHint, 'it is my cat');
      expect(env.session.activeId, user.id);
      expect(user.id, hasLength(36)); // UUID
    });

    test('usernames are unique ignoring case and surrounding spaces', () async {
      await env.useCases.registerUser(input(username: 'Rauf.Aliyev'));
      for (final dup in ['rauf.aliyev', '  RAUF.ALIYEV ', 'Rauf.Aliyev']) {
        expect(
          await failureOf(
            () => env.useCases.registerUser(input(username: dup)),
          ),
          AuthFailure.usernameTaken,
        );
      }
      expect(
        (await env.repos.users.byUsername('rauf.aliyev'))?.username,
        'rauf.aliyev',
      );
    });

    test('invalid input is rejected', () async {
      for (final bad in [
        input(name: 'R'),
        input(username: 'ab'),
        input(username: 'has space'),
        input(password: '12345'),
        input(password: 'secret123', hint: 'my SECRET123 is here'),
      ]) {
        expect(bad.isValid, isFalse);
        expect(
          await failureOf(() => env.useCases.registerUser(bad)),
          AuthFailure.invalidInput,
        );
      }
    });

    test('a hint is fine while no password has been typed yet', () {
      expect(input(password: '', hint: 'first pet').hintOk, isTrue);
      expect(input(password: 'cat', hint: 'my cat').hintOk, isFalse);
    });

    test('an empty hint is stored as null', () async {
      final user = await env.useCases.registerUser(input(hint: '   '));
      expect(user.passwordHint, isNull);
    });
  });

  group('login and logout', () {
    setUp(() async {
      await env.useCases.registerUser(input(hint: 'cat'));
      await env.useCases.logoutUser();
    });

    test(
      'the right password signs in, case of the username does not matter',
      () async {
        final user = await env.useCases.loginUser(' RAUF ', 'secret123');
        expect(env.session.activeId, user.id);
      },
    );

    test('wrong password and unknown user fail the same way', () async {
      expect(
        await failureOf(() => env.useCases.loginUser('rauf', 'nope')),
        AuthFailure.invalidCredentials,
      );
      expect(
        await failureOf(() => env.useCases.loginUser('ghost', 'secret123')),
        AuthFailure.invalidCredentials,
      );
      expect(env.session.activeId, isNull);
    });

    test(
      'the hint is available by username (null when none / unknown)',
      () async {
        expect(await env.useCases.passwordHint(' Rauf'), 'cat');
        expect(await env.useCases.passwordHint('ghost'), isNull);
      },
    );

    test('logging out forgets the user and blocks data access', () async {
      await env.useCases.loginUser('rauf', 'secret123');
      await env.useCases.logoutUser();
      expect(env.session.activeId, isNull);
      expect(() => env.session.id, throwsStateError);
      expect(env.repos.accounts.getAll(), throwsStateError);
    });
  });

  group('session resolution', () {
    test('signed out -> onboarding -> ready', () async {
      await env.useCases.logoutUser();
      expect(await env.useCases.resolveSession(), SessionState.signedOut);
      await env.useCases.loginUser('tester', 'secret123');
      expect(await env.useCases.resolveSession(), SessionState.onboarding);
      await env.repos.onboarding.complete(
        const OnboardingData(cardBalance: 1, cashBalance: 0),
        now,
      );
      expect(await env.useCases.resolveSession(), SessionState.ready);
    });

    test('the session survives a restart (stored id is restored)', () async {
      await env.repos.onboarding.complete(
        const OnboardingData(cardBalance: 1, cashBalance: 0),
        now,
      );
      final restarted = SessionStore(env.db);
      expect(restarted.activeId, isNull);
      expect(await restarted.restore(), env.session.activeId);
    });

    test('a stored id of a missing user is dropped', () async {
      await env.session.signIn('00000000-0000-0000-0000-000000000000');
      expect(await env.useCases.resolveSession(), SessionState.signedOut);
      expect(env.session.activeId, isNull);
    });

    test('signing in or out notifies the database stream', () async {
      final AppDatabase db = env.db;
      final events = <void>[];
      final sub = db.changes.listen(events.add);
      await env.useCases.logoutUser();
      await env.useCases.loginUser('tester', 'secret123');
      await Future<void>.delayed(Duration.zero);
      expect(events.length, 2);
      await sub.cancel();
    });
  });
}
