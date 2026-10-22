import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/core/widgets/category_icon_box.dart';
import 'package:flux_wallet/core/widgets/category_style.dart';
import 'package:flux_wallet/features/statistics/domain/entities/category_share.dart';

/// Icon, name, "33%" and the amount of one category.
class CategoryLegendRow extends StatelessWidget {
  const CategoryLegendRow(this.share, {super.key});

  final CategoryShare share;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      spacing: 12,
      children: [
        CategoryIconBox(share.category, size: 34),
        Expanded(
          child: Text(
            CategoryStyle.of(share.category).label,
            style: TextStyle(fontWeight: FontWeight.w700, color: c.text),
          ),
        ),
        Text(
          formatAzn(share.amount),
          style: TextStyle(fontSize: 12, color: c.textMuted),
        ),
        SizedBox(
          width: 44,
          child: Text(
            '${share.percent.round()}%',
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
          ),
        ),
      ],
    );
  }
}
