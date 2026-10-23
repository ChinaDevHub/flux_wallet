import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/calendar_selection.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_state.dart';

/// Moving around the calendar: another month, back to today, a day.
mixin CalendarNavigation on Cubit<TimelineState> {
  CalendarCursor get cursor;
  Future<void> load();

  Future<void> selectMonth(DateTime month) => _go(month);

  Future<void> goToToday() => _go(null);

  Future<void> _go(DateTime? month) {
    cursor.showMonth(month);
    return load();
  }

  /// A day of the month on show: no reload needed.
  void selectDay(DateTime day) {
    cursor.picked = dateOnly(day);
    final s = state;
    if (s is TimelineLoaded) emit(s.withSelected(cursor.picked!));
  }
}
