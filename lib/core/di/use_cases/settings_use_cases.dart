import 'package:flux_wallet/core/di/use_cases/use_case_deps.dart';
import 'package:flux_wallet/features/settings/domain/repositories/backup_gateway.dart';
import 'package:flux_wallet/features/settings/domain/repositories/reminder_scheduler.dart';
import 'package:flux_wallet/features/settings/domain/usecases/evening_reminder.dart';
import 'package:flux_wallet/features/settings/domain/usecases/export_backup.dart';
import 'package:flux_wallet/features/settings/domain/usecases/import_backup.dart';

/// Backup and the evening reminder (both talk to the phone).
mixin SettingsUseCases on UseCaseDeps {
  BackupGateway get gateway;
  ReminderScheduler get reminders;

  late final exportBackup = ExportBackup(repos.backup, gateway, clock);
  late final importBackup = ImportBackup(repos.backup, gateway);
  late final eveningReminder = EveningReminder(repos.settings, reminders);
}
