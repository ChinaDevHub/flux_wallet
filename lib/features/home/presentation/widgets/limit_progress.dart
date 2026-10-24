import 'package:flutter/material.dart';
import 'package:flux_wallet/features/home/presentation/widgets/limit_bar_line.dart';
import 'package:flux_wallet/features/home/presentation/widgets/limit_progress_caption.dart';

/// The bar of today's limit and the line under it.
class LimitProgress extends StatelessWidget {
  const LimitProgress({
    super.key,
    required this.ratio,
    required this.spent,
    this.color = Colors.white,
  });

  final double ratio;
  final double spent;

  /// The bar takes the colour of today's state once it is not calm.
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        LimitBarLine(ratio: ratio, color: color),
        LimitProgressCaption(ratio: ratio, spent: spent),
      ],
    );
  }
}
