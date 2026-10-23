import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/widgets/manage/row_action.dart';

/// The same [actions] as visible buttons, for an expanded row.
class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key, required this.actions});

  final List<RowAction> actions;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final a in actions)
          OutlinedButton.icon(
            onPressed: a.onTap,
            icon: Icon(a.icon, size: 18),
            label: Text(a.label),
            style: OutlinedButton.styleFrom(
              foregroundColor: a.destructive ? c.negative : c.text,
              side: BorderSide(
                color: a.destructive
                    ? c.negative.withValues(alpha: 0.5)
                    : c.divider,
              ),
              shape: const StadiumBorder(),
            ),
          ),
      ],
    );
  }
}
