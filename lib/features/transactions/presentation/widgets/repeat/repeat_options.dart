import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan_copy.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/repeat/repeat_days_row.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/repeat/repeat_end_row.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/repeat/repeat_summary.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/repeat/skip_months_row.dart';

/// Under the frequency chips: days, end, paused months, and a summary.
class RepeatOptions extends StatelessWidget {
  const RepeatOptions({super.key, required this.plan, required this.start});
  final RecurrencePlan plan;
  final DateTime start;

  @override
  Widget build(BuildContext context) {
    final update = context.read<NewTransactionCubit>().updateRepeat;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          if (plan.picksDays)
            RepeatDaysRow(
              plan: plan,
              onToggle: (d) => update(plan.toggleWeekday(d)),
            ),
          RepeatEndRow(
            plan: plan,
            start: start,
            onChanged: (e) => update(plan.copyWith(end: e)),
          ),
          SkipMonthsRow(
            selected: plan.skipMonths,
            onChanged: (m) => update(plan.copyWith(skipMonths: m)),
          ),
          RepeatSummary(plan: plan, start: start),
        ],
      ),
    );
  }
}
