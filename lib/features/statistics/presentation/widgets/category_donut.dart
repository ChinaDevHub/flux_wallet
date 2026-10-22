import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/widgets/category_style.dart';
import 'package:flux_wallet/features/statistics/domain/entities/category_share.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/donut_center.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/donut_painter.dart';

/// The ring with the month's total expense in the middle.
class CategoryDonut extends StatelessWidget {
  const CategoryDonut(this.shares, {super.key});

  final List<CategoryShare> shares;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final total = shares.fold(0.0, (s, e) => s + e.amount);
    return SizedBox.square(
      dimension: 190,
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: 1),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        builder: (_, t, child) => CustomPaint(
          painter: DonutPainter(
            fractions: [for (final s in shares) s.percent / 100],
            colors: [
              for (final s in shares) CategoryStyle.of(s.category).color,
            ],
            track: c.surfaceAlt,
            progress: t,
          ),
          child: child,
        ),
        child: Center(child: DonutCenter(total)),
      ),
    );
  }
}
