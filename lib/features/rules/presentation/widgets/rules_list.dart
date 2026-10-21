import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_refresh.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/empty_rules.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/rule_tile.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/rules_section_header.dart';

typedef RuleToggle = void Function(RecurringRule rule, bool active);

class RulesList extends StatelessWidget {
  const RulesList({
    super.key,
    required this.active,
    required this.passive,
    required this.onToggle,
    required this.onRefresh,
  });

  final List<RecurringRule> active, passive;
  final RuleToggle onToggle;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    Widget tile(RecurringRule r) =>
        RuleTile(rule: r, onToggle: (v) => onToggle(r, v));
    return AdaptiveRefresh(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          if (active.isEmpty && passive.isEmpty) const EmptyRules(),
          if (active.isNotEmpty) ...[
            const RulesSectionHeader('Aktiv'),
            ...active.map(tile),
          ],
          if (passive.isNotEmpty) ...[
            const RulesSectionHeader('Passiv'),
            ...passive.map(tile),
          ],
        ],
      ),
    );
  }
}
