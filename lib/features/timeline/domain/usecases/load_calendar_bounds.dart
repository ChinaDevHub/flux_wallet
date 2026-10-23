import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/budget/domain/usecases/tracking_start.dart';
import 'package:flux_wallet/features/timeline/domain/entities/calendar_bounds.dart';

class LoadCalendarBounds {
  const LoadCalendarBounds(this._tracking, this._clock);

  final TrackingStart _tracking;
  final Clock _clock;

  Future<CalendarBounds> call() async {
    final today = dateOnly(_clock());
    return CalendarBounds(
      first: await _tracking(today),
      last: CalendarBounds.lastDay(today),
    );
  }
}
