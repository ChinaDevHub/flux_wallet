import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/security/domain/entities/lock_timeout.dart';
import 'package:flux_wallet/features/security/presentation/cubit/app_lock_cubit.dart';
import 'package:flux_wallet/features/security/presentation/cubit/pin_flow_cubit.dart';
import 'package:flux_wallet/features/security/presentation/cubit/pin_flow_state.dart';
import '../../support/test_env.dart';

void main() {
  late TestEnv env;
  var now = DateTime(2026, 10, 20, 9);

  setUp(() async {
    now = DateTime(2026, 10, 20, 9);
    env = await openTestEnv();
  });
  tearDown(() => env.close());

  AppLockCubit cubit({bool lockedAtStart = false}) => AppLockCubit(
    pin: env.useCases.appPin,
    autoLock: env.useCases.autoLock,
    users: env.repos.users,
    clock: () => now,
    changes: env.db.changes,
    lockedAtStart: lockedAtStart,
  );

  test('without a PIN nothing ever locks', () async {
    final c = cubit(lockedAtStart: true);
    await c.load();
    expect(c.state.locked, isFalse);
    c.hidden();
    now = now.add(const Duration(hours: 1));
    c.shown();
    expect(c.state.locked, isFalse);
    expect(c.state.curtain, isFalse);
    await c.close();
  });

  test('with a PIN: locked at start, curtain in the background, re-lock '
      'only after the timeout', () async {
    await env.useCases.appPin.set('2468');
    final c = cubit(lockedAtStart: true);
    await c.load();
    expect(c.state.locked, isTrue);
    expect(c.state.user?.username, 'tester');
    c.unlock();
    expect(c.state.locked, isFalse);

    c.inactive();
    expect(c.state.curtain, isTrue);
    c.shown();
    expect(c.state.locked, isFalse, reason: 'control centre is not leaving');

    c.hidden();
    now = now.add(const Duration(seconds: 30));
    c.shown();
    expect(c.state.locked, isFalse, reason: 'default timeout is a minute');

    c.hidden();
    now = now.add(const Duration(seconds: 61));
    c.shown();
    expect(c.state.locked, isTrue);
    expect(c.state.curtain, isFalse);
    await c.close();
  });

  test('"Dərhal" locks on any return from the background', () async {
    await env.useCases.appPin.set('2468');
    await env.useCases.autoLock.write(LockTimeout.immediately);
    final c = cubit();
    await c.load();
    c.hidden();
    c.shown();
    expect(c.state.locked, isTrue);
    await c.close();
  });

  test('removing the PIN (or signing out) drops the lock', () async {
    await env.useCases.appPin.set('2468');
    final c = cubit(lockedAtStart: true);
    await c.load();
    await env.useCases.appPin.clear();
    await c.load();
    expect(c.state.enabled, isFalse);
    expect(c.state.locked, isFalse);
    await c.close();
  });

  test(
    'set-up flow: mismatch restarts, match saves; remove needs the current',
    () async {
      final pin = env.useCases.appPin;
      final create = PinFlowCubit(pin, PinFlowMode.create);
      expect(create.state.step, PinFlowStep.enter);
      create.setLength(6);
      await create.submit('123456');
      expect(create.state.step, PinFlowStep.confirm);
      await create.submit('654321');
      expect(create.state.step, PinFlowStep.enter);
      expect(create.state.error, isNotNull);
      expect(create.state.resetTick, 1);
      await create.submit('123456');
      await create.submit('123456');
      expect(create.state.step, PinFlowStep.done);
      expect(await pin.verify('123456'), isTrue);
      await create.close();

      final remove = PinFlowCubit(pin, PinFlowMode.remove);
      await remove.init();
      expect(remove.state.activeLength, 6);
      await remove.submit('000000');
      expect(remove.state.step, PinFlowStep.current);
      expect(remove.state.error, 'Cari PIN yanlışdır');
      await remove.submit('123456');
      expect(remove.state.step, PinFlowStep.done);
      expect(await pin.isSet(), isFalse);
      await remove.close();
    },
  );
}
