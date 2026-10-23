import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flux_wallet/core/platform/adaptive_actions.dart';
import 'package:flux_wallet/core/widgets/manage/row_action.dart';
import 'package:flux_wallet/core/widgets/manage/swipe_pane.dart';

/// Makes a row manageable: swipe it sideways for [actions] (labelled
/// buttons that scroll in on iOS, a drawer behind the row on Android), or
/// press and hold for the same list in the platform's menu. With no actions
/// it is just the [child].
class SwipeActions extends StatelessWidget {
  const SwipeActions({
    super.key,
    required this.title,
    required this.actions,
    required this.child,
  });

  final String title;
  final List<RowAction> actions;
  final Widget child;

  void _menu(BuildContext context) {
    HapticFeedback.mediumImpact();
    showRowActions(context, title: title, actions: actions);
  }

  @override
  Widget build(BuildContext context) {
    if (actions.isEmpty) return child;
    return GestureDetector(
      onLongPress: () => _menu(context),
      child: Slidable(endActionPane: swipePane(context, actions), child: child),
    );
  }
}
