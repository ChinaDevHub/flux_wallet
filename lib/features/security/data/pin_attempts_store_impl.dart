import 'package:flux_wallet/features/security/domain/entities/lock_attempts.dart';
import 'package:flux_wallet/features/security/domain/repositories/pin_attempts_store.dart';
import 'package:flux_wallet/features/settings/domain/scoped_settings.dart';

/// The signed-in user's wrong-PIN count and wait, as per-user settings.
class PinAttemptsStoreImpl implements PinAttemptsStore {
  const PinAttemptsStoreImpl(this._settings);

  static const _failed = 'pin_failed', _until = 'pin_blocked_until';
  final ScopedSettings _settings;

  @override
  Future<LockAttempts> read() async => LockAttempts(
    failed: int.tryParse(await _settings.read(_failed) ?? '') ?? 0,
    blockedUntil: DateTime.tryParse(await _settings.read(_until) ?? ''),
  );

  @override
  Future<void> save(LockAttempts a) async {
    await _settings.write(_failed, '${a.failed}');
    final until = a.blockedUntil;
    if (until == null) return _settings.clear(_until);
    await _settings.write(_until, until.toIso8601String());
  }

  @override
  Future<void> clear() async {
    await _settings.clear(_failed);
    await _settings.clear(_until);
  }
}
