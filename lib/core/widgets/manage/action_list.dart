import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/widgets/manage/row_action.dart';

/// Android's menu of a row: one list tile per action, red for delete.
class ActionList extends StatelessWidget {
  const ActionList({super.key, required this.actions, required this.onPick});

  final List<RowAction> actions;
  final ValueChanged<RowAction> onPick;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final a in actions)
            ListTile(
              leading: Icon(a.icon, color: a.destructive ? c.negative : c.text),
              title: Text(
                a.label,
                style: TextStyle(color: a.destructive ? c.negative : c.text),
              ),
              onTap: () => onPick(a),
            ),
        ],
      ),
    );
  }
}
