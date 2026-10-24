import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/timeline/domain/entities/calendar_bounds.dart';
import 'package:flux_wallet/features/timeline/domain/entities/calendar_day_open.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_view.dart';

/// Where the user is in the calendar: the month on show (null = the
/// current one) and the day they picked (null = the default for it).
class CalendarCursor {
  DateTime? month, picked;

  void showMonth(DateTime? m) {
    month = m == null ? null : monthStart(m);
    picked = null;
  }

  /// The month to load.
  DateTime monthFor(DateTime today) => month ?? monthStart(today);

  /// The picked day while it can still be opened, else today in the current
  /// month, else the month's first day that can be opened (or its first).
  DateTime selectedIn(
    TimelineView view,
    CalendarBounds bounds,
    DateTime today,
  ) {
    final open = view.days.where(bounds.opens).map((d) => d.date).toList();
    final p = picked;
    if (p != null && open.contains(p)) return p;
    if (open.contains(today)) return today;
    return open.firstOrNull ?? view.month;
  }
}
