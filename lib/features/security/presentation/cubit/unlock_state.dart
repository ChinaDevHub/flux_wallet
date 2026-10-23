import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/security/domain/entities/lock_attempts.dart';

class UnlockState extends Equatable {
  const UnlockState({
    this.attempts = const LockAttempts(),
    this.failures = 0,
    this.secondsLeft = 0,
    this.checking = false,
  });

  final LockAttempts attempts;

  /// Total wrong tries this session; the pad clears itself when it grows.
  final int failures;
  final int secondsLeft;
  final bool checking;

  bool get blocked => secondsLeft > 0;

  /// What to say under the dots, or null when all is fine.
  String? get caption {
    if (blocked) return 'Çox yanlış cəhd · $secondsLeft saniyə gözlə';
    if (failures > 0) return 'Yanlış PIN · ${attempts.remaining} cəhd qaldı';
    return null;
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
