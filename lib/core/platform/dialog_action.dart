import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// One dialog button: CupertinoDialogAction on iOS, TextButton on Android.
Widget dialogAction(
  BuildContext context, {
  required String label,
  required VoidCallback onPressed,
  required bool cupertino,
  bool destructive = false,
}) {
  if (cupertino) {
    return CupertinoDialogAction(
      isDestructiveAction: destructive,
      onPressed: onPressed,
      child: Text(label),
    );
  }
  final c = context.colors;
  return TextButton(
    onPressed: onPressed,
    child: Text(
      label,
      style: TextStyle(color: destructive ? c.negative : c.primary),
    ),
  );
}
