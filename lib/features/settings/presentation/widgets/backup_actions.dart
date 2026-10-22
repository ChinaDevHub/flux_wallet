import 'package:flutter/widgets.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/backup_runner.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/settings_result.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/confirm_import.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_messages.dart';

/// Shares the backup file; the share sheet is its own feedback, so only a
/// problem is reported.
Future<void> runExport(BuildContext context, BackupRunner backup) async {
  final result = await backup.export();
  if (context.mounted && result != SettingsResult.done) {
    showSettingsResult(context, result);
  }
}

/// Asks first (it replaces the current data), then restores from a file.
Future<void> runImport(BuildContext context, BackupRunner backup) async {
  if (!await confirmImport(context)) return;
  final result = await backup.import();
  if (!context.mounted) return;
  showSettingsResult(context, result, done: 'Məlumatlar bərpa olundu');
}
