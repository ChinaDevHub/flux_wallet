import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/status_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// A tinted note with an info icon: what an action will do.
class InfoBox extends StatelessWidget {
  const InfoBox(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: c.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Icon(StatusIcons.info, size: 18, color: c.primary),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12.5, height: 1.4, color: c.text),
            ),
          ),
        ],
      ),
    );
  }
}
