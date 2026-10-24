import 'package:flux_wallet/features/settings/domain/repositories/data_reset_repository.dart';

/// "Datanı sıfırla": back to a clean slate. The user lands on first-time
/// setup again, and the calendar starts over with the first new record.
class ResetData {
  const ResetData(this._reset);

  final DataResetRepository _reset;

  Future<void> call() => _reset.wipe();
}
