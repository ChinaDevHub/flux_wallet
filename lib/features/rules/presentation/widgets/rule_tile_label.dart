import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/rule_schedule_label.dart';

class RuleTileLabel extends StatelessWidget {
  const RuleTileLabel(this.rule, {super.key});

  final RecurringRule rule;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          rule.title,
          style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
        ),
        Text(
          ruleScheduleLabel(rule),
          style: TextStyle(fontSize: 12, color: c.textMuted),
        ),
      ],
    );
  }
}
