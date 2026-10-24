import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/security/domain/entities/lock_attempts.dart';
import 'package:flux_wallet/features/security/domain/usecases/pin_guard.dart';
import 'package:flux_wallet/features/security/presentation/cubit/unlock_state.dart';

/// Checks a typed PIN through the [PinGuard] and counts down a running wait.
/// The wait is read from disk first, so it goes on after a restart.
class UnlockCubit extends Cubit<UnlockState> {
  UnlockCubit(this._guard, this._clock, {required this.onUnlocked})
    : super(const UnlockState());

  final PinGuard _guard;
  final Clock _clock;
  final void Function() onUnlocked;
  Timer? _timer;

  Future<void> init() async => _show(await _guard.attempts(), state.failures);

  Future<void> submit(String pin) async {
    if (state.checking || state.blocked) return;
    emit(state.copyWith(checking: true));
    final result = await _guard.check(pin);
    if (isClosed) return;
    if (result == null) return onUnlocked();
    _show(result, state.failures + 1);
  }

  void _show(LockAttempts attempts, int failures) {
    if (isClosed) return;
    emit(UnlockState(attempts: attempts, failures: failures));
    _tick();
  }

  void _tick() {
    _timer?.cancel();
    final left = state.attempts.secondsLeft(_clock());
    emit(state.copyWith(secondsLeft: left));
    if (left > 0) _timer = Timer(const Duration(seconds: 1), _tick);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
