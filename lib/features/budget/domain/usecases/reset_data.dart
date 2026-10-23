import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/budget/domain/usecases/tracking_start.dart';
import 'package:flux_wallet/features/settings/domain/repositories/data_reset_repository.dart';

/// "Datanı sıfırla": back to a clean slate. The user lands on first-time
/// setup again; the calendar starts over from today.
class ResetData {
  const ResetData(this._reset, this._tracking, this._clock);

  final DataResetRepository _reset;
  final TrackingStart _tracking;
  final Clock _clock;

  Future<void> call() async {
    await _tracking.restart(dateOnly(_clock()));
    await _reset.wipe();
  }
}
