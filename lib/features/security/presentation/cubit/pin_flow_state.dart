import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/security/domain/entities/pin_policy.dart';

enum PinFlowMode { create, change, remove }

/// `current`: prove the existing PIN; `enter` + `confirm`: the new one.
enum PinFlowStep { current, enter, confirm, done }

class PinFlowState extends Equatable {
  const PinFlowState({
    required this.step,
    this.length = PinPolicy.defaultLength,
    this.currentLength = PinPolicy.defaultLength,
    this.first,
    this.error,
    this.resetTick = 0,
    this.saving = false,
  });

  /// Creating starts with the new PIN; changing or removing proves the old.
  const PinFlowState.start(PinFlowMode mode)
    : this(
        step: mode == PinFlowMode.create
            ? PinFlowStep.enter
            : PinFlowStep.current,
      );

  final PinFlowStep step;

  /// Digits of the new PIN being chosen, and of the one already set.
  final int length, currentLength;
  final String? first;
  final String? error;

  /// Grows whenever the pad must shake and clear.
  final int resetTick;
  final bool saving;

  int get activeLength => step == PinFlowStep.current ? currentLength : length;

  @override
  List<Object?> get props => [
    step, length, currentLength, first, error, resetTick, saving, //
  ];
}
