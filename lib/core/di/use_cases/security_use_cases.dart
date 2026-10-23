import 'package:flux_wallet/core/di/use_cases/auth_use_cases.dart';
import 'package:flux_wallet/features/security/domain/usecases/app_pin.dart';
import 'package:flux_wallet/features/security/domain/usecases/auto_lock.dart';

/// The PIN lock: the user's PIN and the device's auto-lock delay.
mixin SecurityUseCases on AuthUseCases {
  late final appPin = AppPin(repos.pins, hasher);
  late final autoLock = AutoLock(repos.settings);
}
