import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/security/domain/entities/lock_timeout.dart';
import 'package:flux_wallet/features/security/domain/entities/pin_policy.dart';

class AppLockState extends Equatable {
  const AppLockState({
    this.enabled = false,
    this.locked = false,
    this.hidden = false,
    this.pinLength = PinPolicy.defaultLength,
    this.timeout = LockTimeout.fallback,
    this.user,
  });

  /// The signed-in user has a PIN.
  final bool enabled;

  /// The lock screen is up.
  final bool locked;

  /// The app is not in front (switcher, another app, control centre).
  final bool hidden;
  final int pinLength;
  final LockTimeout timeout;
  final User? user;

  /// Hides the content in the app switcher while a PIN protects the app.
  bool get curtain => enabled && hidden && !locked;

  @override
  List<Object?> get props => [
    enabled,
    locked,
    hidden,
    pinLength,
    timeout,
    user,
  ];
}
