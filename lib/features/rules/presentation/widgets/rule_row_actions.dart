import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/icons/action_icons.dart';
import 'package:flux_wallet/core/widgets/manage/row_action.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/presentation/pages/open_rule_edit.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/confirm_delete_rule.dart';

/// Redaktə et and Sil for a rule: the same two actions wherever a rule is
/// shown (rules list, calendar day, ...). Debt payments have no id and are
/// managed on the Borclar tab, so they get none. [from] is the day an edit
/// should start from when the rule is opened from a particular day.
List<RowAction> ruleRowActions(
  BuildContext context,
  RecurringRule rule, {
  required Future<void> Function(RecurringRule) onDelete,
  DateTime? from,
}) {
  if (rule.id == null) return const [];
  return [
    RowAction(
      label: 'Redaktə et',
      icon: ActionIcons.edit,
      onTap: () => openRuleEdit(context, rule, from: from),
    ),
    RowAction(
      label: 'Sil',
      icon: ActionIcons.delete,
      destructive: true,
      onTap: () async {
        if (await confirmDeleteRule(context, rule)) await onDelete(rule);
      },
    ),
  ];
}
