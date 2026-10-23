import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/arrow_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/domain/entities/calendar_bounds.dart';

/// A previous / next month button, greyed when [onTap] is null (the end of
/// the calendar).
class MonthArrow extends StatelessWidget {
  const MonthArrow({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return IconButton(
      tooltip: tooltip,
      onPressed: onTap,
      icon: Icon(
        icon,
        color: onTap == null ? c.textMuted.withValues(alpha: 0.4) : c.text,
      ),
    );
  }
}

/// The previous and next buttons around [month]; [go] moves by ±1.
(MonthArrow, MonthArrow) monthArrows(
  CalendarBounds b,
  DateTime month,
  void Function(int step) go,
) => (
  MonthArrow(
    icon: ArrowIcons.prev,
    tooltip: 'Əvvəlki ay',
    onTap: b.hasMonthBefore(month) ? () => go(-1) : null,
  ),
  MonthArrow(
    icon: ArrowIcons.next,
    tooltip: 'Növbəti ay',
    onTap: b.hasMonthAfter(month) ? () => go(1) : null,
  ),
);
