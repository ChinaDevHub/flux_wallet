import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/app_switch.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/core/widgets/category_icon_box.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/rule_tile_label.dart';

class RuleTile extends StatelessWidget {
  const RuleTile({super.key, required this.rule, required this.onToggle});

  final RecurringRule rule;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Opacity(
      opacity: rule.isActive ? 1 : 0.55,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          spacing: 12,
          children: [
            CategoryIconBox(rule.category),
            Expanded(child: RuleTileLabel(rule)),
            Text(
              formatAzn(
                rule.isIncome ? rule.amount : -rule.amount,
                signed: true,
              ),
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: rule.isIncome ? c.positive : c.text,
              ),
            ),
            AppSwitch(value: rule.isActive, onChanged: onToggle),
          ],
        ),
      ),
    );
  }
}
