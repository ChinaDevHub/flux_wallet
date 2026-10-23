import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/status_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';

/// The red heads-up of a day that went over its limit.
class OverLimitNote extends StatelessWidget {
  const OverLimitNote({super.key, required this.over});

  final double over;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: c.negative.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        spacing: 8,
        children: [
          Icon(StatusIcons.warning, size: 18, color: c.negative),
          Expanded(
            child: Text(
              'Limit ${formatAzn(over)} aşılıb',
              style: TextStyle(fontWeight: FontWeight.w700, color: c.negative),
            ),
          ),
        ],
      ),
    );
  }
}
