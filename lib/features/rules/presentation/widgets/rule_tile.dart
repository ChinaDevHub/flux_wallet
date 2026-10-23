import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/app_switch.dart';
import 'package:flux_wallet/core/widgets/category_icon_box.dart';
import 'package:flux_wallet/core/widgets/manage/swipe_actions.dart';
import 'package:flux_wallet/core/widgets/signed_amount.dart';
import 'package:flux_wallet/core/widgets/surface_card.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/rule_row_actions.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/rule_tile_label.dart';

/// A rule: switch it on or off; swipe (or hold) for edit and delete.
class RuleTile extends StatelessWidget {
  const RuleTile({
    super.key,
    required this.rule,
    required this.onToggle,
    required this.onDelete,
  });

  final RecurringRule rule;
  final ValueChanged<bool> onToggle;
  final Future<void> Function(RecurringRule) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SwipeActions(
        title: rule.title,
        actions: ruleRowActions(context, rule, onDelete: onDelete),
        child: Opacity(
          opacity: rule.isActive ? 1 : 0.55,
          child: SurfaceCard(
            radius: 18,
            padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
            child: Row(
              spacing: 12,
              children: [
                CategoryIconBox(rule.category),
                Expanded(child: RuleTileLabel(rule)),
                SignedAmount(rule.isIncome ? rule.amount : -rule.amount),
                AppSwitch(value: rule.isActive, onChanged: onToggle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
