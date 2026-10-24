import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/security/domain/entities/pin_policy.dart';

/// Wrong PINs since the last right one, and until when the pad is paused.
/// It is kept on disk, so leaving the app does not reset the wait.
class LockAttempts extends Equatable {
  const LockAttempts({this.failed = 0, this.blockedUntil});

  final int failed;
  final DateTime? blockedUntil;

  /// Free tries left before the first wait (0 once waits have begun).
  int get remaining =>
      (PinPolicy.maxAttempts - failed).clamp(0, PinPolicy.maxAttempts);

  bool isBlocked(DateTime now) =>
      blockedUntil != null && now.isBefore(blockedUntil!);

  /// Whole seconds until the pad works again (0 when it does).
  int secondsLeft(DateTime now) {
    final until = blockedUntil;
    if (until == null || !now.isBefore(until)) return 0;
    return (until.difference(now).inMilliseconds / 1000).ceil();
  }

  /// One more wrong PIN: from the fifth on, each one starts a longer wait.
  LockAttempts fail(DateTime now) {
    final count = failed + 1;
    final lockout = count - PinPolicy.maxAttempts + 1;
    if (lockout < 1) return LockAttempts(failed: count);
    return LockAttempts(
      failed: count,
      blockedUntil: now.add(PinPolicy.waitAfter(lockout)),
    );
  }

  @override
  List<Object?> get props => [failed, blockedUntil];
}
