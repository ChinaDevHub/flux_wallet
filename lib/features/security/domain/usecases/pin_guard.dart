import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/security/domain/entities/lock_attempts.dart';
import 'package:flux_wallet/features/security/domain/repositories/pin_attempts_store.dart';
import 'package:flux_wallet/features/security/domain/usecases/app_pin.dart';

/// The lock screen's gatekeeper: a PIN is only checked when no wait is
/// running, every wrong one is written down at once, and the right one
/// wipes the count.
class PinGuard {
  const PinGuard(this._pin, this._store, this._clock);

  final AppPin _pin;
  final PinAttemptsStore _store;
  final Clock _clock;

  Future<LockAttempts> attempts() => _store.read();

  /// Null when [pin] unlocks; otherwise the attempts as they now stand.
  Future<LockAttempts?> check(String pin) async {
    final before = await _store.read();
    if (before.isBlocked(_clock())) return before;
    if (await _pin.verify(pin)) {
      await _store.clear();
      return null;
    }
    final after = before.fail(_clock());
    await _store.save(after);
    return after;
  }

  /// Signing out (the password is needed to come back) starts afresh.
  Future<void> reset() => _store.clear();
}
