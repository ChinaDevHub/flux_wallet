import 'package:flutter/cupertino.dart';
import 'package:flux_wallet/core/platform/adaptive_sheet.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';
import 'package:flux_wallet/core/widgets/manage/action_list.dart';
import 'package:flux_wallet/core/widgets/manage/row_action.dart';

/// The actions of a row as the platform's own menu: an action sheet on iOS,
/// a bottom sheet list on Android. Picking one closes the menu first.
Future<void> showRowActions(
  BuildContext context, {
  required String title,
  required List<RowAction> actions,
}) {
  void run(BuildContext ctx, RowAction a) {
    Navigator.pop(ctx);
    a.onTap();
  }

  if (!context.isCupertino) {
    return showAppSheet<void>(
      context,
      (ctx) => ActionList(actions: actions, onPick: (a) => run(ctx, a)),
    );
  }
  return showCupertinoModalPopup<void>(
    context: context,
    builder: (ctx) => CupertinoActionSheet(
      title: Text(title),
      actions: [
        for (final a in actions)
          CupertinoActionSheetAction(
            isDestructiveAction: a.destructive,
            onPressed: () => run(ctx, a),
            child: Text(a.label),
          ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(ctx),
        child: const Text('Bağla'),
      ),
    ),
  );
}
