import 'package:flux_wallet/features/settings/domain/repositories/backup_gateway.dart';
import 'package:flux_wallet/features/settings/domain/repositories/backup_repository.dart';

class ImportBackup {
  const ImportBackup(this._backup, this._gateway);

  final BackupRepository _backup;
  final BackupGateway _gateway;

  /// False when the user cancelled the file picker.
  Future<bool> call() async {
    final text = await _gateway.pickFile();
    if (text == null) return false;
    await _backup.importJson(text);
    return true;
  }
}
