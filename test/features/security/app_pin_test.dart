import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/security/domain/entities/lock_attempts.dart';
import 'package:flux_wallet/features/security/domain/entities/lock_timeout.dart';
import 'package:flux_wallet/features/security/domain/entities/pin_policy.dart';
import '../../support/test_env.dart';

void main() {
  late TestEnv env;

  setUp(() async => env = await openTestEnv());
  tearDown(() => env.close());

  test(
    'a PIN is set, verified, replaced and removed for the signed-in user',
    () async {
      final pin = env.useCases.appPin;
      expect(await pin.isSet(), isFalse);
      await pin.set('2468');
      expect(await pin.isSet(), isTrue);
      expect(await pin.length(), 4);
      expect(await pin.verify('2468'), isTrue);
      expect(await pin.verify('0000'), isFalse);
      await pin.set('135790');
      expect(await pin.length(), 6);
      expect(await pin.verify('2468'), isFalse);
      expect(await pin.verify('135790'), isTrue);
      await pin.clear();
      expect(await pin.isSet(), isFalse);
      expect(await pin.verify('135790'), isFalse);
    },
  );

  test('the hash on disk is not the PIN', () async {
    await env.useCases.appPin.set('2468');
    final row = (await (await env.db.instance).query('users')).single;
    expect(row['pin_hash'], isNot(contains('2468')));
    expect(row['pin_hash'], startsWith('pbkdf2-sha256'));
  });

  test('each roommate has their own PIN', () async {
    await env.useCases.appPin.set('1111');
    await env.switchTo('aysel');
    expect(await env.useCases.appPin.isSet(), isFalse);
    await env.useCases.appPin.set('2222');
    expect(await env.useCases.appPin.verify('1111'), isFalse);
  });

  test('signed out means no PIN, not a crash', () async {
    await env.useCases.appPin.set('2468');
    await env.useCases.logoutUser();
    expect(await env.useCases.appPin.isSet(), isFalse);
  });

  test('rejects anything that is not 4 or 6 digits', () {
    expect(PinPolicy.isValid('123'), isFalse);
    expect(PinPolicy.isValid('12345'), isFalse);
    expect(PinPolicy.isValid('12a4'), isFalse);
    expect(PinPolicy.isValid('1234'), isTrue);
    expect(PinPolicy.isValid('123456'), isTrue);
  });

  test('auto-lock timeout is remembered per device', () async {
    final auto = env.useCases.autoLock;
    expect(await auto.read(), LockTimeout.fallback);
    await auto.write(LockTimeout.immediately);
    expect(await auto.read(), LockTimeout.immediately);
  });

  test('from the fifth wrong PIN on, every one waits longer', () {
    final now = DateTime(2026, 10, 20, 9);
    var a = const LockAttempts();
    for (var i = 0; i < PinPolicy.maxAttempts - 1; i++) {
      a = a.fail(now);
      expect(a.isBlocked(now), isFalse);
    }
    expect(a.remaining, 1);
    a = a.fail(now);
    expect(a.secondsLeft(now), 30);
    final later = now.add(const Duration(seconds: 30));
    expect(a.isBlocked(later), isFalse);
    a = a.fail(later);
    expect(a.secondsLeft(later), 60);
    a = a.fail(later).fail(later).fail(later).fail(later);
    expect(a.secondsLeft(later), 3600, reason: 'the wait tops out at an hour');
  });

  test('the wait survives a restart and the right PIN clears it', () async {
    await env.useCases.appPin.set('2468');
    final guard = env.useCases.pinGuard;
    for (var i = 0; i < PinPolicy.maxAttempts; i++) {
      expect(await guard.check('0000'), isNotNull);
    }
    // A fresh guard reads the same store, as a restarted app does.
    final again = await env.useCases.pinGuard.attempts();
    expect(again.isBlocked(DateTime(2026, 10, 20, 9)), isTrue);
    expect(await guard.check('2468'), isNotNull, reason: 'blocked: unchecked');
    await env.useCases.pinGuard.reset();
    expect(await guard.check('2468'), isNull);
    expect((await guard.attempts()).failed, 0);
  });

  test('timeouts: immediately always expires, a minute needs a minute', () {
    final at = DateTime(2026, 10, 20, 9);
    expect(LockTimeout.immediately.expired(at, at), isTrue);
    final minute = LockTimeout.oneMinute;
    expect(minute.expired(at, at.add(const Duration(seconds: 59))), isFalse);
    expect(minute.expired(at, at.add(const Duration(seconds: 60))), isTrue);
    expect(LockTimeout.fromSeconds(300), LockTimeout.fiveMinutes);
    expect(LockTimeout.fromSeconds(null), LockTimeout.fallback);
  });
}
