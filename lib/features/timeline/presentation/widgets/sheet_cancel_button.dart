import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

class SheetCancelButton extends StatelessWidget {
  const SheetCancelButton(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(label, style: TextStyle(color: context.colors.textMuted)),
      ),
    );
  }
}
