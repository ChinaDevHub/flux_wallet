import 'package:flux_wallet/features/timeline/domain/entities/calendar_bounds.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';

extension CalendarDayOpen on CalendarBounds {
  /// Whether [day] can be opened: today and the days ahead always; a day
  /// that is over only when something happened on it.
  bool opens(TimelineDay day) =>
      contains(day.date) && (!day.isPast || day.entries.isNotEmpty);
}
