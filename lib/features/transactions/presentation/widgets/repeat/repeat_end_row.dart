import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_segmented.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_end.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/repeat/end_kind.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/repeat/repeat_end_detail.dart';

/// "Nə vaxt bitir": open-ended, after N times, or until a date.
class RepeatEndRow extends StatelessWidget {
  const RepeatEndRow({
    super.key,
    required this.plan,
    required this.start,
    required this.onChanged,
  });

  final RecurrencePlan plan;
  final DateTime start;
  final ValueChanged<RecurrenceEnd> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'Nə vaxt bitir',
          style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
        ),
        SizedBox(
          width: double.infinity,
          child: AdaptiveSegmented<EndKind>(
            selected: EndKind.of(plan.end),
            onChanged: (k) => onChanged(k.defaultFor(start)),
            options: {for (final k in EndKind.values) k: k.label},
          ),
        ),
        RepeatEndDetail(end: plan.end, start: start, onChanged: onChanged),
      ],
    );
  }
}
