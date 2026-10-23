import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/arrow_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/az_calendar.dart';

/// "Oktyabr 2026 ⌄": tap to jump to another month.
class MonthTitle extends StatelessWidget {
  const MonthTitle({
    super.key,
    required this.month,
    required this.onTap,
    required this.large,
  });

  final DateTime month;
  final VoidCallback onTap;

  /// iOS shows it as a large left-aligned title.
  final bool large;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Text(
              azMonthYear(month),
              style: TextStyle(
                fontSize: large ? 24 : 18,
                fontWeight: FontWeight.w800,
                color: c.text,
              ),
            ),
            Icon(ArrowIcons.down, size: 20, color: c.primary),
          ],
        ),
      ),
    );
  }
}
