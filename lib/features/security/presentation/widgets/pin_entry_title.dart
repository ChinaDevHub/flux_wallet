import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// "Salam, Rauf" and the line under it.
class PinEntryTitle extends StatelessWidget {
  const PinEntryTitle({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: c.text,
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 6, 32, 0),
            child: Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, height: 1.35, color: c.textMuted),
            ),
          ),
      ],
    );
  }
}
