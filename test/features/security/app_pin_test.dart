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

  test('five wrong tries block the pad for the cooldown', () {
    final now = DateTime(2026, 10, 20, 9);
    var a = const LockAttempts();
    for (var i = 0; i < PinPolicy.maxAttempts - 1; i++) {
      a = a.fail(now);
      expect(a.isBlocked(now), isFalse);
    }
    expect(a.remaining, 1);
    a = a.fail(now);
    expect(a.isBlocked(now), isTrue);
    expect(a.secondsLeft(now), PinPolicy.cooldown.inSeconds);
    expect(a.isBlocked(now.add(PinPolicy.cooldown)), isFalse);
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
