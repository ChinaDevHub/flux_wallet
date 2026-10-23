import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/security/domain/usecases/app_pin.dart';
import 'package:flux_wallet/features/security/presentation/cubit/unlock_state.dart';

/// Checks a typed PIN; counts failures and runs the cooldown countdown.
class UnlockCubit extends Cubit<UnlockState> {
  UnlockCubit(this._pin, this._clock, {required this.onUnlocked})
    : super(const UnlockState());

  final AppPin _pin;
  final Clock _clock;
  final VoidCallback onUnlocked;
  Timer? _timer;

  Future<void> submit(String pin) async {
    if (state.checking || state.blocked) return;
    emit(state.copyWith(checking: true));
    final ok = await _pin.verify(pin);
    if (isClosed) return;
    if (ok) return onUnlocked();
    emit(
      UnlockState(
        attempts: state.attempts.fail(_clock()),
        failures: state.failures + 1,
      ),
    );
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

typedef VoidCallback = void Function();
