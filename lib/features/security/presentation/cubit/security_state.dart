import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/security/domain/entities/lock_timeout.dart';

/// What the settings screen shows about the PIN lock.
class SecurityState extends Equatable {
  const SecurityState({
    this.pinEnabled = false,
    this.pinLength,
    this.timeout = LockTimeout.fallback,
  });

  final bool pinEnabled;
  final int? pinLength;
  final LockTimeout timeout;

  @override
  List<Object?> get props => [pinEnabled, pinLength, timeout];
}
