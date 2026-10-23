import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/security/domain/entities/lock_timeout.dart';
import 'package:flux_wallet/features/security/presentation/cubit/app_lock_state.dart';

extension AppLockStateCopy on AppLockState {
  AppLockState copyWith({
    bool? enabled,
    bool? locked,
    bool? hidden,
    int? pinLength,
    LockTimeout? timeout,
    User? user,
  }) => AppLockState(
    enabled: enabled ?? this.enabled,
    locked: locked ?? this.locked,
    hidden: hidden ?? this.hidden,
    pinLength: pinLength ?? this.pinLength,
    timeout: timeout ?? this.timeout,
    user: user ?? this.user,
  );
}
