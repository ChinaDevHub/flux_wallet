import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/settings/domain/repositories/backup_gateway.dart';
import 'package:flux_wallet/features/settings/domain/repositories/backup_repository.dart';

class ExportBackup {
  const ExportBackup(this._backup, this._gateway, this._clock);

  final BackupRepository _backup;
  final BackupGateway _gateway;
  final Clock _clock;

  Future<void> call() async {
    final now = _clock();
    final day = dayKey(now).replaceAll('-', '');
    await _gateway.shareFile(
      'flux_wallet_$day.json',
      await _backup.exportJson(now),
    );
  }
}
