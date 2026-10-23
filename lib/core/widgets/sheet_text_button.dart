import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// Closes the sheet, then runs [then].
void closeThen(BuildContext context, VoidCallback then) {
  Navigator.pop(context);
  then();
}

/// A red text button at the foot of a sheet that closes it first.
class SheetTextButton extends StatelessWidget {
  const SheetTextButton(this.label, {super.key, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Center(
    child: TextButton(
      onPressed: () => closeThen(context, onTap),
      child: Text(label, style: TextStyle(color: context.colors.negative)),
    ),
  );
}
