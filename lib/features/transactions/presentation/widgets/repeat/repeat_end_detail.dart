import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/core/widgets/count_stepper.dart';
import 'package:flux_wallet/core/widgets/day_button.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_end.dart';

/// The control under the end selector: a counter or a date.
class RepeatEndDetail extends StatelessWidget {
  const RepeatEndDetail({
    super.key,
    required this.end,
    required this.start,
    required this.onChanged,
  });

  final RecurrenceEnd end;
  final DateTime start;
  final ValueChanged<RecurrenceEnd> onChanged;

  @override
  Widget build(BuildContext context) {
    final muted = TextStyle(fontSize: 12, color: context.colors.textMuted);
    return switch (end) {
      NeverEnds() => const SizedBox.shrink(),
      EndsAfter(:final count) => Row(
        spacing: 12,
        children: [
          CountStepper(
            value: count,
            min: 2,
            onChanged: (v) => onChanged(EndsAfter(v)),
          ),
          Text('dəfə, bu gün daxil', style: muted),
        ],
      ),
      EndsOn(:final date) => Row(
        children: [
          Expanded(child: Text('Son gün', style: muted)),
          DayButton(
            date: date,
            first: addDays(start, 1),
            last: DateTime(start.year + 30, start.month, start.day),
            onPicked: (d) => onChanged(EndsOn(d)),
          ),
        ],
      ),
    };
  }
}
