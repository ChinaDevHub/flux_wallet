import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/status_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';

class ShortfallBanner extends StatelessWidget {
  const ShortfallBanner({super.key, required this.amount});

  final double amount;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: c.accentSoft,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: c.accent.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(StatusIcons.warning, color: c.accent),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Məcburi xərclərə ${formatMoney(amount)} $azn çatmır',
              style: TextStyle(fontWeight: FontWeight.w700, color: c.accent),
            ),
          ),
        ],
      ),
    );
  }
}
