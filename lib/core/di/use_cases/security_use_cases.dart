import 'package:flux_wallet/core/di/use_cases/auth_use_cases.dart';
import 'package:flux_wallet/features/security/data/pin_attempts_store_impl.dart';
import 'package:flux_wallet/features/security/domain/usecases/app_pin.dart';
import 'package:flux_wallet/features/security/domain/usecases/pin_guard.dart';
import 'package:flux_wallet/features/security/domain/usecases/auto_lock.dart';

/// The PIN lock: the user's PIN, its guard and the auto-lock delay.
mixin SecurityUseCases on AuthUseCases {
  late final _attempts = PinAttemptsStoreImpl(repos.userSettings);
  late final appPin = AppPin(repos.pins, hasher, _attempts);
  late final pinGuard = PinGuard(appPin, _attempts, clock);
  late final autoLock = AutoLock(repos.settings);
}
