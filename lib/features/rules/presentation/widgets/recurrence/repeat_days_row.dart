import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan_copy.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/recurrence/weekday_strip.dart';

/// "Günlər": switch off the days the expense does not happen (remote day).
class RepeatDaysRow extends StatelessWidget {
  const RepeatDaysRow({super.key, required this.plan, required this.onChanged});

  final RecurrencePlan plan;
  final ValueChanged<RecurrencePlan> onChanged;

  String get _hint => switch (plan.frequency) {
    Frequency.weekdays => 'Uzaqdan iş günün varsa, söndür',
    Frequency.weekly => 'Həftənin günlərini seç',
    _ => 'Lazım olmayan günü söndür',
  };

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Row(
          children: [
            Text(
              'Günlər',
              style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
            ),
            const Spacer(),
            Text(_hint, style: TextStyle(fontSize: 11, color: c.textMuted)),
          ],
        ),
        WeekdayStrip(
          selected: plan.weekdays,
          onToggle: (d) => onChanged(plan.toggleWeekday(d)),
        ),
      ],
    );
  }
}
