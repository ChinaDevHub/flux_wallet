import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/auth/domain/repositories/user_repository.dart';
import 'package:flux_wallet/features/security/domain/usecases/app_pin.dart';
import 'package:flux_wallet/features/security/domain/usecases/auto_lock.dart';
import 'package:flux_wallet/features/security/presentation/cubit/app_lock_state.dart';
import 'package:flux_wallet/features/security/presentation/cubit/app_lock_state_copy.dart';
import 'package:flux_wallet/features/security/presentation/cubit/lock_lifecycle.dart';

/// Whether the lock screen is up. It follows the database (PIN set or
/// removed, user signed out) and the app's time in the background.
class AppLockCubit extends ReloadingCubit<AppLockState> with LockLifecycle {
  AppLockCubit({
    required this.pin,
    required this.autoLock,
    required this.users,
    required this.clock,
    required Stream<void> changes,
    bool lockedAtStart = false,
  }) : super(
         AppLockState(enabled: lockedAtStart, locked: lockedAtStart),
         changes,
       );

  final AppPin pin;
  final AutoLock autoLock;
  final UserRepository users;
  @override
  final Clock clock;

  @override
  Future<void> load() async {
    final enabled = await pin.isSet();
    emit(
      state.copyWith(
        enabled: enabled,
        locked: enabled && state.locked,
        pinLength: await pin.length(),
        timeout: await autoLock.read(),
        user: enabled ? await users.current() : null,
      ),
    );
  }
}
