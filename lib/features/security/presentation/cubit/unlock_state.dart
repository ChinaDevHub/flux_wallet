import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/security/domain/entities/lock_attempts.dart';
import 'package:flux_wallet/features/security/presentation/cubit/wait_text.dart';

class UnlockState extends Equatable {
  const UnlockState({
    this.attempts = const LockAttempts(),
    this.failures = 0,
    this.secondsLeft = 0,
    this.checking = false,
  });

  /// Wrong PINs so far and the running wait, as stored on disk.
  final LockAttempts attempts;

  /// Wrong tries on this screen; the pad shakes and clears when it grows.
  final int failures;
  final int secondsLeft;
  final bool checking;

  bool get blocked => secondsLeft > 0;

  /// What to say under the dots, or null when all is fine.
  String? get caption {
    if (blocked) return 'Çox yanlış cəhd · ${waitText(secondsLeft)} gözlə';
    if (attempts.failed == 0) return null;
    final left = attempts.remaining;
    return left > 0 ? 'Yanlış PIN · $left cəhd qaldı' : 'Yanlış PIN';
  }

  UnlockState copyWith({int? secondsLeft, bool? checking}) => UnlockState(
    attempts: attempts,
    failures: failures,
    secondsLeft: secondsLeft ?? this.secondsLeft,
    checking: checking ?? this.checking,
  );

  @override
  List<Object?> get props => [attempts, failures, secondsLeft, checking];
}
