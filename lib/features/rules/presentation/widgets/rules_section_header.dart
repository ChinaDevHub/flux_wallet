import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

class RulesSectionHeader extends StatelessWidget {
  const RulesSectionHeader(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: context.colors.textMuted,
        ),
      ),
    );
  }
}
