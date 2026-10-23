import 'package:flux_wallet/features/security/presentation/cubit/pin_flow_state.dart';

extension PinFlowStateCopy on PinFlowState {
  /// [clearFirst] / [clearError] reset a field to null.
  PinFlowState copyWith({
    PinFlowStep? step,
    int? length,
    int? currentLength,
    String? first,
    bool clearFirst = false,
    String? error,
    bool clearError = false,
    int? resetTick,
    bool? saving,
  }) => PinFlowState(
    step: step ?? this.step,
    length: length ?? this.length,
    currentLength: currentLength ?? this.currentLength,
    first: clearFirst ? null : first ?? this.first,
    error: clearError ? null : error ?? this.error,
    resetTick: resetTick ?? this.resetTick,
    saving: saving ?? this.saving,
  );

  /// Shake the pad and say why.
  PinFlowState rejected(String message) =>
      copyWith(error: message, resetTick: resetTick + 1);
}
