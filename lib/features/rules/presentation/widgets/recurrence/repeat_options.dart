import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/surface_card.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan_copy.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/recurrence/end_kind.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/recurrence/repeat_days_row.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/recurrence/repeat_end_row.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/recurrence/repeat_summary.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/recurrence/skip_months_row.dart';

/// Days, end, paused months and a summary of a [plan] from [start].
class RepeatOptions extends StatelessWidget {
  const RepeatOptions({
    super.key,
    required this.plan,
    required this.start,
    required this.onChanged,
    this.endKinds = EndKind.values,
  });

  final RecurrencePlan plan;
  final DateTime start;
  final ValueChanged<RecurrencePlan> onChanged;
  final List<EndKind> endKinds;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          if (plan.picksDays) RepeatDaysRow(plan: plan, onChanged: onChanged),
          RepeatEndRow(
            plan: plan,
            start: start,
            kinds: endKinds,
            onChanged: (e) => onChanged(plan.copyWith(end: e)),
          ),
          SkipMonthsRow(
            selected: plan.skipMonths,
            onChanged: (m) => onChanged(plan.copyWith(skipMonths: m)),
          ),
          RepeatSummary(plan: plan, start: start),
        ],
      ),
    );
  }
}
