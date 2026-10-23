import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/action_icons.dart';
import 'package:flux_wallet/core/icons/status_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_end.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan_draft.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule_copy.dart';
import 'package:flux_wallet/features/rules/domain/usecases/resolve_rule_end.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/rule_schedule_label.dart';

/// One muted line saying what the plan will do, in the rules screen's words.
class RepeatSummary extends StatelessWidget {
  const RepeatSummary({super.key, required this.plan, required this.start});

  final RecurrencePlan plan;
  final DateTime start;

  String get _text {
    final draft = plan.draft(title: '', amount: 0, category: '', start: start);
    final end = plan.end;
    final times = end is EndsAfter ? '${end.count} dəfə · ' : '';
    final last = const ResolveRuleEnd()(draft, end);
    return '$times${ruleScheduleLabel(draft.copyWith(endDate: last))}';
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final invalid = !plan.isValid;
    final color = invalid ? c.negative : c.textMuted;
    return Row(
      spacing: 8,
      children: [
        Icon(
          invalid ? StatusIcons.warning : ActionIcons.repeat,
          size: 16,
          color: invalid ? c.negative : c.primary,
        ),
        Expanded(
          child: Text(
            invalid ? 'Ən azı bir gün seç' : _text,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ),
      ],
    );
  }
}
