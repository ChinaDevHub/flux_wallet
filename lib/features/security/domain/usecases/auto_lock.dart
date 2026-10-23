import 'package:flux_wallet/features/security/domain/entities/lock_timeout.dart';
import 'package:flux_wallet/features/settings/domain/entities/setting_keys.dart';
import 'package:flux_wallet/features/settings/domain/repositories/settings_repository.dart';

/// The background grace period before the PIN is asked again.
class AutoLock {
  const AutoLock(this._settings);

  final SettingsRepository _settings;

  Future<LockTimeout> read() async {
    final raw = await _settings.read(SettingKeys.autoLock);
    return LockTimeout.fromSeconds(int.tryParse(raw ?? ''));
  }

  Future<void> write(LockTimeout timeout) =>
      _settings.write(SettingKeys.autoLock, '${timeout.seconds}');
}
