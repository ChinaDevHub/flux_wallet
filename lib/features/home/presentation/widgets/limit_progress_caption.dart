import 'package:flutter/material.dart';
import 'package:flux_wallet/core/utils/money_format.dart';

/// "Gündəlik limitdən 40% qalıb ... 12.00 ₼ xərclənib".
class LimitProgressCaption extends StatelessWidget {
  const LimitProgressCaption({
    super.key,
    required this.ratio,
    required this.spent,
  });

  final double ratio, spent;

  @override
  Widget build(BuildContext context) {
    const muted = TextStyle(fontSize: 11, color: Colors.white70);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 8,
      children: [
        Flexible(
          child: Text(
            'Gündəlik limitdən ${(ratio * 100).round()}% qalıb',
            overflow: TextOverflow.ellipsis,
            style: muted,
          ),
        ),
        Text('${formatMoney(spent)} $azn xərclənib', style: muted),
      ],
    );
  }
}
