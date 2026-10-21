import 'package:flutter/material.dart';
import 'package:flux_wallet/core/utils/money_format.dart';

class LimitBudgetCaption extends StatelessWidget {
  const LimitBudgetCaption(this.budget, {super.key});

  final double budget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.bottomLeft,
        child: Text(
          '/ ${formatMoney(budget)} $azn qalıb',
          style: const TextStyle(fontSize: 13, color: Colors.white70),
        ),
      ),
    );
  }
}
