import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

class UpcomingAmount extends StatelessWidget {
  const UpcomingAmount(this.rule, {super.key});

  final RecurringRule rule;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final amount = rule.isIncome ? rule.amount : -rule.amount;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        formatAzn(amount, signed: true),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: rule.isIncome ? c.positive : c.accent,
        ),
      ),
    );
  }
}
