import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/widgets/day_row.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule_live.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rule_edit_state.dart';

/// "Qüvvəyə minir": the day the change starts, and a note on what stays.
class RuleEditFrom extends StatelessWidget {
  const RuleEditFrom({super.key, required this.state, required this.onPicked});

  final RuleEditState state;
  final ValueChanged<DateTime> onPicked;

  @override
  Widget build(BuildContext context) {
    final s = state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DayRow(
          title: 'Qüvvəyə minir',
          subtitle: 'Dəyişiklik bu gündən etibarən keçərlidir',
          date: s.from,
          first: s.today,
          last: DateTime(s.today.year + 3, s.today.month, s.today.day),
          onPicked: onPicked,
        ),
        if (s.rule.hasHistory(s.today))
          Text(
            'Keçmiş günlər dəyişməyəcək: onların məbləği, günləri və limiti '
            'olduğu kimi qalır.',
            style: TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: context.colors.textMuted,
            ),
          ),
        if (s.edit.endsBeforeStart)
          Text(
            'Bitmə tarixi başlanğıcdan əvvəldir.',
            style: TextStyle(fontSize: 12.5, color: context.colors.negative),
          ),
      ],
    );
  }
}
