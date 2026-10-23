import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/security/presentation/cubit/app_lock_state.dart';
import 'package:flux_wallet/features/security/presentation/cubit/app_lock_state_copy.dart';

/// How the app's time away from the screen turns into a lock.
mixin LockLifecycle on Cubit<AppLockState> {
  Clock get clock;
  DateTime? _hiddenAt;

  /// Not in front any more (a sheet, the switcher): only the curtain.
  void inactive() => emit(state.copyWith(hidden: true));

  /// Went to the background: the clock for the auto-lock starts.
  void hidden() {
    _hiddenAt ??= clock();
    emit(state.copyWith(hidden: true));
  }

  /// Back in front: lock when it stayed away longer than the timeout.
  void shown() {
    final at = _hiddenAt;
    _hiddenAt = null;
    final expired = at != null && state.timeout.expired(at, clock());
    final lock = state.locked || (state.enabled && expired);
    emit(state.copyWith(hidden: false, locked: lock));
  }

  void unlock() => emit(state.copyWith(locked: false));
}
