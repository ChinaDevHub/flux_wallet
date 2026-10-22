import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/dialog_action.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';

/// A message with one "OK" button, as a native alert on each platform.
Future<void> infoDialog(
  BuildContext context, {
  required String title,
  required String message,
  String okLabel = 'Bağla',
}) {
  final cupertino = context.isCupertino;
  return showAdaptiveDialog<void>(
    context: context,
    builder: (ctx) {
      final ok = dialogAction(
        ctx,
        label: okLabel,
        cupertino: cupertino,
        onPressed: () => Navigator.pop(ctx),
      );
      final content = Text(message);
      return cupertino
          ? CupertinoAlertDialog(
              title: Text(title),
              content: content,
              actions: [ok],
            )
          : AlertDialog(title: Text(title), content: content, actions: [ok]);
    },
  );
}
