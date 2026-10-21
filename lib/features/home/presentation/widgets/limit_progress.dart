import 'package:flutter/material.dart';
import 'package:flux_wallet/core/utils/money_format.dart';

class LimitProgress extends StatelessWidget {
  const LimitProgress({super.key, required this.ratio, required this.spent});

  final double ratio;
  final double spent;

  @override
  Widget build(BuildContext context) {
    const muted = TextStyle(fontSize: 11, color: Colors.white70);
    return Column(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(end: ratio),
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          builder: (_, v, _) => ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: v,
              minHeight: 6,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'Gündəlik limitdən ${(ratio * 100).round()}% qalıb',
                overflow: TextOverflow.ellipsis,
                style: muted,
              ),
            ),
            const SizedBox(width: 8),
            Text('${formatMoney(spent)} $azn xərclənib', style: muted),
          ],
        ),
      ],
    );
  }
}
