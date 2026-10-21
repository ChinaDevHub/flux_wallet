import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/core/widgets/category_icon_box.dart';
import 'package:flux_wallet/features/home/presentation/widgets/today_tile_label.dart';

/// One row in the "Bu gün" list; [planned] rows are muted automatic plans.
class TodayTile extends StatelessWidget {
  const TodayTile({
    super.key,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.signedAmount,
    this.planned = false,
  });

  final String category, title, subtitle;
  final double signedAmount;
  final bool planned;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final main = planned ? c.textMuted : c.text;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      child: Row(
        children: [
          CategoryIconBox(category),
          const SizedBox(width: 12),
          Expanded(child: TodayTileLabel(title, subtitle, muted: planned)),
          Text(
            formatAzn(signedAmount, signed: true),
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: signedAmount > 0 ? c.positive : main,
            ),
          ),
        ],
      ),
    );
  }
}
