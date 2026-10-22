import 'package:flutter/material.dart';
import 'package:flux_wallet/core/utils/az_calendar.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day_off_row.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/sheet_cancel_button.dart';
import 'package:flux_wallet/core/widgets/sheet_heading.dart';

/// Popup for a day without planned entries: only the day-off switch.
class DaySheet extends StatelessWidget {
  const DaySheet({
    super.key,
    required this.date,
    required this.dayOff,
    required this.onDayOffChanged,
  });

  final DateTime date;
  final bool dayOff;
  final ValueChanged<bool> onDayOffChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SheetHeading(azFullDate(date)),
          const SizedBox(height: 14),
          DayOffRow(initial: dayOff, onChanged: onDayOffChanged),
          const SheetCancelButton('Bağla'),
        ],
      ),
    );
  }
}
