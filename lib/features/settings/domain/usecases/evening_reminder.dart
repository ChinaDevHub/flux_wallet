import 'package:flux_wallet/features/settings/domain/entities/setting_keys.dart';
import 'package:flux_wallet/features/settings/domain/repositories/reminder_scheduler.dart';
import 'package:flux_wallet/features/settings/domain/repositories/settings_repository.dart';

/// The daily "Nağd xərcin oldumu?" nudge at 21:00.
class EveningReminder {
  const EveningReminder(this._settings, this._scheduler);

  static const hour = 21;
  static const title = 'Nağd xərcin oldumu?';
  static const body = 'Bu gün nağd xərclədiklərini əlavə etməyi unutma.';

  final SettingsRepository _settings;
  final ReminderScheduler _scheduler;

  Future<bool> isEnabled() async =>
      await _settings.read(SettingKeys.eveningReminder) == '1';

  /// False when notifications were refused (nothing is scheduled then).
  Future<bool> enable() async {
    if (!await _scheduler.requestPermission()) return false;
    await _scheduler.scheduleDaily(hour, 0, title, body);
    await _settings.write(SettingKeys.eveningReminder, '1');
    return true;
  }

  Future<void> disable() async {
    await _scheduler.cancel();
    await _settings.write(SettingKeys.eveningReminder, '0');
  }

  /// Called at start-up: schedules survive reboots but not reinstalls/restores.
  Future<void> restore() async {
    if (await isEnabled()) await _scheduler.scheduleDaily(hour, 0, title, body);
  }
}
