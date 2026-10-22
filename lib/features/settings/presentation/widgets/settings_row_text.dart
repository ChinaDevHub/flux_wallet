import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

class SettingsRowText extends StatelessWidget {
  const SettingsRowText(this.title, this.subtitle, {super.key});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w700, color: c.text),
        ),
        if (subtitle != null)
          Text(subtitle!, style: TextStyle(fontSize: 12, color: c.textMuted)),
      ],
    );
  }
}
