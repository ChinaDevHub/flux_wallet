import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: c.primary,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            Icons.account_balance_wallet_rounded,
            color: c.onPrimary,
            size: 28,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: TextStyle(
            fontSize: 28,
            height: 1.15,
            fontWeight: FontWeight.w800,
            color: c.text,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(fontSize: 15, height: 1.4, color: c.textMuted),
        ),
      ],
    );
  }
}
