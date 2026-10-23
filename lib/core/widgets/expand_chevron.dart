import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/arrow_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// The chevron of an accordion row: it turns over while [open].
class ExpandChevron extends StatelessWidget {
  const ExpandChevron({super.key, required this.open});

  final bool open;

  @override
  Widget build(BuildContext context) => AnimatedRotation(
    turns: open ? 0.5 : 0,
    duration: const Duration(milliseconds: 200),
    child: Icon(ArrowIcons.down, size: 20, color: context.colors.textMuted),
  );
}
