import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_refresh.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/empty_rules.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/rule_tile.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/rules_hint.dart';

typedef RuleToggle = void Function(RecurringRule rule, bool on);

/// All rules in one list: the switch turns a rule on or off, swiping (or
/// pressing and holding) a row offers edit and delete.
class RulesList extends StatelessWidget {
  const RulesList({
    super.key,
    required this.rules,
    required this.onToggle,
    required this.onDelete,
    required this.onRefresh,
  });

  final List<RecurringRule> rules;
  final RuleToggle onToggle;
  final Future<void> Function(RecurringRule) onDelete;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return AdaptiveRefresh(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          if (rules.isEmpty) const EmptyRules(),
          for (final r in rules)
            RuleTile(
              key: ValueKey(r.id),
              rule: r,
              onToggle: (v) => onToggle(r, v),
              onDelete: onDelete,
            ),
          if (rules.isNotEmpty) const RulesHint(),
        ],
      ),
    );
  }
}
