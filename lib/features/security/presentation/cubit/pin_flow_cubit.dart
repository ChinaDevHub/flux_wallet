import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/security/domain/usecases/app_pin.dart';
import 'package:flux_wallet/features/security/presentation/cubit/pin_flow_state.dart';
import 'package:flux_wallet/features/security/presentation/cubit/pin_flow_state_copy.dart';

/// Set, change or remove the PIN, one pad screen per step.
class PinFlowCubit extends Cubit<PinFlowState> {
  PinFlowCubit(this._pin, this.mode) : super(PinFlowState.start(mode));

  final AppPin _pin;
  final PinFlowMode mode;

  /// The current PIN's length decides when the first pad checks it.
  Future<void> init() async {
    final n = await _pin.length();
    if (n != null) emit(state.copyWith(currentLength: n, length: n));
  }

  void setLength(int length) => emit(state.copyWith(length: length));

  Future<void> submit(String pin) => switch (state.step) {
    PinFlowStep.current => _checkCurrent(pin),
    PinFlowStep.enter => _goTo(PinFlowStep.confirm, first: pin),
    PinFlowStep.confirm => _confirm(pin),
    PinFlowStep.done => Future.value(),
  };

  Future<void> _checkCurrent(String pin) async {
    final ok = await _pin.verify(pin);
    if (!ok) return emit(state.rejected('Cari PIN yanlışdır'));
    if (mode == PinFlowMode.remove) return _finish(_pin.clear);
    return _goTo(PinFlowStep.enter);
  }

  Future<void> _confirm(String pin) async {
    if (pin == state.first) return _finish(() => _pin.set(pin));
    final back = state.copyWith(step: PinFlowStep.enter, clearFirst: true);
    emit(back.rejected('PIN kodlar eyni deyil. Yenidən başla'));
  }

  Future<void> _goTo(PinFlowStep step, {String? first}) async =>
      emit(state.copyWith(step: step, first: first, clearError: true));

  Future<void> _finish(Future<void> Function() action) async {
    emit(state.copyWith(saving: true));
    await action();
    emit(state.copyWith(step: PinFlowStep.done, saving: false));
  }
}
