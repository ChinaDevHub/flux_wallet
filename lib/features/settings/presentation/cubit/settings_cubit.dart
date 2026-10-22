import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/features/notifications/domain/repositories/notification_source.dart';
import 'package:flux_wallet/features/notifications/domain/repositories/pending_repository.dart';
import 'package:flux_wallet/features/settings/domain/usecases/evening_reminder.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/backup_runner.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/settings_result.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/settings_state.dart';

class SettingsCubit extends ReloadingCubit<SettingsState> {
  SettingsCubit({
    required this.reminder,
    required this.source,
    required this.pending,
    required this.backup,
    required Stream<void> changes,
  }) : super(const SettingsState(), changes);

  final EveningReminder reminder;
  final NotificationSource source;
  final PendingRepository pending;
  final BackupRunner backup;

  @override
  Future<void> load() async => emit(
    SettingsState(
      reminderEnabled: await reminder.isEnabled(),
      accessSupported: source.isSupported,
      accessGranted: await source.isAccessGranted(),
      pendingCount: await pending.countPending(),
    ),
  );

  Future<SettingsResult> setReminder(bool on) async {
    if (on && !await reminder.enable()) return SettingsResult.denied;
    if (!on) await reminder.disable();
    await load();
    return SettingsResult.done;
  }

  Future<void> openAccess() => source.openAccessSettings();
}
