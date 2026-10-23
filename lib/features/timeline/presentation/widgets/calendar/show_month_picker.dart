import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/platform/adaptive_sheet.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';
import 'package:flux_wallet/features/timeline/domain/entities/calendar_bounds.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/month_choice_grid.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/month_wheel.dart';

/// Jump to any month of the calendar: a wheel on iOS, chips on Android.
Future<DateTime?> showMonthPicker(
  BuildContext context, {
  required CalendarBounds bounds,
  required DateTime current,
}) {
  final cupertino = context.isCupertino;
  return showAppSheet<DateTime>(
    context,
    (_) => cupertino
        ? MonthWheel(months: bounds.months, initial: current)
        : MonthChoiceGrid(months: bounds.months, initial: current),
  );
}
