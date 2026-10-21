import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

class TodayTileLabel extends StatelessWidget {
  const TodayTileLabel(
    this.title,
    this.subtitle, {
    super.key,
    this.muted = false,
  });

  final String title, subtitle;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: muted ? c.textMuted : c.text,
          ),
        ),
        Text(subtitle, style: TextStyle(fontSize: 12, color: c.textMuted)),
      ],
    );
  }
}
