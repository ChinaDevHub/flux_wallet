import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

class SheetHeading extends StatelessWidget {
  const SheetHeading(this.title, {super.key, this.description});

  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: c.text,
          ),
        ),
        if (description != null) ...[
          const SizedBox(height: 6),
          Text(
            description!,
            style: TextStyle(fontSize: 13, color: c.textMuted),
          ),
        ],
      ],
    );
  }
}
