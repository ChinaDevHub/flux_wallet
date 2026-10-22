import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/dialog_action.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';

/// Yes/no question as a native alert (Cupertino on iOS, Material on Android).
Future<bool> confirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  bool destructive = false,
}) async {
  final cupertino = context.isCupertino;
  final result = await showAdaptiveDialog<bool>(
    context: context,
    builder: (ctx) {
      final actions = [
        dialogAction(
          ctx,
          label: 'Ləğv et',
          cupertino: cupertino,
          onPressed: () => Navigator.pop(ctx, false),
        ),
        dialogAction(
          ctx,
          label: confirmLabel,
          cupertino: cupertino,
          destructive: destructive,
          onPressed: () => Navigator.pop(ctx, true),
        ),
      ];
      final content = Text(message);
      return cupertino
          ? CupertinoAlertDialog(
              title: Text(title),
              content: content,
              actions: actions,
            )
          : AlertDialog(title: Text(title), content: content, actions: actions);
    },
  );
  return result ?? false;
}
