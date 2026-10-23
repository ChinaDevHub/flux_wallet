import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/timeline/domain/entities/calendar_bounds.dart';

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

  /// The picked day when it lies in [m], else today when [m] is the current
  /// month, else the first day the calendar has there.
  DateTime selectedIn(DateTime m, CalendarBounds bounds, DateTime today) {
    final p = picked;
    if (p != null && monthStart(p) == m) return p;
    if (m == monthStart(today)) return today;
    return m.isBefore(monthStart(bounds.first)) ? bounds.first : m;
  }
}
