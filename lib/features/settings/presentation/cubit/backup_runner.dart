import 'package:flux_wallet/features/settings/domain/entities/backup_exception.dart';
import 'package:flux_wallet/features/settings/domain/usecases/export_backup.dart';
import 'package:flux_wallet/features/settings/domain/usecases/import_backup.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/settings_result.dart';

/// Runs export / import and turns the outcome into a [SettingsResult].
class BackupRunner {
  const BackupRunner(this._export, this._import);

  final ExportBackup _export;
  final ImportBackup _import;

  Future<SettingsResult> export() => _run(() async {
    await _export();
    return SettingsResult.done;
  });

  Future<SettingsResult> import() => _run(() async {
    return await _import() ? SettingsResult.done : SettingsResult.cancelled;
  });

  Future<SettingsResult> _run(Future<SettingsResult> Function() action) async {
    try {
      return await action();
    } on BackupException {
      return SettingsResult.invalid;
    } catch (_) {
      return SettingsResult.failed;
    }
  }
}
