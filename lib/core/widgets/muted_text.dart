import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// Small secondary text: captions, hints and explanations.
class MutedText extends StatelessWidget {
  const MutedText(this.text, {super.key, this.size = 12.5});

  final String text;
  final double size;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      fontSize: size,
      height: 1.4,
      color: context.colors.textMuted,
    ),
  );
}
