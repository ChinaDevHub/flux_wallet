import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/widgets/manage/row_action.dart';

/// The buttons a swipe reveals: they scroll in with the row on iOS and sit
/// in a drawer behind it on Android. Delete is red, the rest brand green.
ActionPane swipePane(BuildContext context, List<RowAction> actions) {
  final c = context.colors;
  return ActionPane(
    motion: context.isCupertino ? const ScrollMotion() : const DrawerMotion(),
    extentRatio: (0.22 * actions.length).clamp(0.22, 0.7),
    children: [
      for (final a in actions)
        SlidableAction(
          onPressed: (_) => a.onTap(),
          icon: a.icon,
          label: a.label,
          spacing: 4,
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(18),
          backgroundColor: a.destructive ? c.negative : c.primary,
          foregroundColor: Colors.white,
        ),
    ],
  );
}
