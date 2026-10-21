import 'package:flutter/material.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/home/presentation/widgets/animated_amount.dart';
import 'package:flux_wallet/features/home/presentation/widgets/limit_budget_caption.dart';

/// The big "14.42 ₼ / 22.42 ₼ qalıb" line; scales down for large amounts.
class LimitHeroAmount extends StatelessWidget {
  const LimitHeroAmount({
    super.key,
    required this.remaining,
    required this.budget,
  });

  final double remaining, budget;

  @override
  Widget build(BuildContext context) {
    const bold = TextStyle(fontWeight: FontWeight.w800, color: Colors.white);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 8,
      children: [
        Flexible(
          flex: 3,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.bottomLeft,
            child: Row(
              spacing: 6,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                AnimatedAmount(
                  value: remaining,
                  style: bold.copyWith(fontSize: 52, height: 1),
                ),
                Text(azn, style: bold.copyWith(fontSize: 28)),
              ],
            ),
          ),
        ),
        Flexible(flex: 2, child: LimitBudgetCaption(budget)),
      ],
    );
  }
}
