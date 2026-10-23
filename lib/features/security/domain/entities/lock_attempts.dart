import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/security/domain/entities/pin_policy.dart';

/// Wrong PINs so far; after [PinPolicy.maxAttempts] in a row the pad pauses
/// for [PinPolicy.cooldown], which makes guessing pointless.
class LockAttempts extends Equatable {
  const LockAttempts({this.failed = 0, this.blockedUntil});

  final int failed;
  final DateTime? blockedUntil;

  int get remaining => PinPolicy.maxAttempts - failed;

  bool isBlocked(DateTime now) =>
      blockedUntil != null && now.isBefore(blockedUntil!);

  /// Whole seconds until the pad works again (0 when it does).
  int secondsLeft(DateTime now) {
    final until = blockedUntil;
    if (until == null || !now.isBefore(until)) return 0;
    return (until.difference(now).inMilliseconds / 1000).ceil();
  }

  LockAttempts fail(DateTime now) {
    final count = failed + 1;
    if (count < PinPolicy.maxAttempts) return LockAttempts(failed: count);
    return LockAttempts(blockedUntil: now.add(PinPolicy.cooldown));
  }

  @override
  List<Object?> get props => [failed, blockedUntil];
}
