import 'package:flutter/material.dart';

/// The padded, left-aligned column every bottom sheet is laid out in.
class SheetBody extends StatelessWidget {
  const SheetBody({super.key, required this.children, this.spacing = 12});

  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spacing,
      children: children,
    ),
  );
}
