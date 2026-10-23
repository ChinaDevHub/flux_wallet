import 'package:flux_wallet/core/session/current_user.dart';
import 'package:flux_wallet/features/settings/domain/repositories/settings_repository.dart';

/// Per-user preferences kept in the device's key/value `settings` table: the
/// signed-in user's id is part of every key, so roommates never see or
/// overwrite each other's values. A blank value means "not set".
class ScopedSettings {
  const ScopedSettings(this._settings, this._user);

  final SettingsRepository _settings;
  final CurrentUser _user;

  String _key(String name) => '${_user.id}.$name';

  Future<String?> read(String name) async {
    final value = await _settings.read(_key(name));
    return value == null || value.isEmpty ? null : value;
  }

  Future<void> write(String name, String value) =>
      _settings.write(_key(name), value);

  Future<void> clear(String name) => write(name, '');
}
