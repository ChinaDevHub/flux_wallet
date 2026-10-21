import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// Title + subtitle on the left, a control on the right.
class FormRow extends StatelessWidget {
  const FormRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final String title, subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: c.textMuted),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
