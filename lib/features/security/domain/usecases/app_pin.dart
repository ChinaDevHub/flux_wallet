import 'package:flux_wallet/features/auth/domain/repositories/password_hasher.dart';
import 'package:flux_wallet/features/security/domain/entities/pin_policy.dart';
import 'package:flux_wallet/features/security/domain/entities/stored_pin.dart';
import 'package:flux_wallet/features/security/domain/repositories/pin_attempts_store.dart';
import 'package:flux_wallet/features/security/domain/repositories/pin_repository.dart';

/// The signed-in user's PIN: set, check, remove. It is hashed like the
/// password; a new or removed PIN also clears the wrong-PIN count.
class AppPin {
  const AppPin(this._pins, this._hasher, this._attempts);

  final PinRepository _pins;
  final PasswordHasher _hasher;
  final PinAttemptsStore _attempts;

  /// False when nobody is signed in or no PIN was set.
  Future<bool> isSet() async => await _read() != null;

  Future<int?> length() async => (await _read())?.length;

  Future<void> set(String pin) async {
    if (!PinPolicy.isValid(pin)) throw ArgumentError.value(pin, 'pin');
    final hash = await _hasher.hash(pin);
    await _pins.save(StoredPin(hash: hash, length: pin.length));
    await _attempts.clear();
  }

  Future<bool> verify(String pin) async {
    final stored = await _read();
    return stored != null && await _hasher.verify(pin, stored.hash);
  }

  Future<void> clear() async {
    await _pins.clear();
    await _attempts.clear();
  }

  Future<StoredPin?> _read() async {
    try {
      return await _pins.current();
    } on StateError {
      return null; // signed out
    }
  }
}
