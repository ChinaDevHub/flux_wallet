import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/planned_payment.dart';
import 'package:flux_wallet/core/widgets/category_style.dart';

class UpcomingCardHeader extends StatelessWidget {
  const UpcomingCardHeader(this.payment, this.today, {super.key});

  final PlannedPayment payment;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final style = CategoryStyle.of(payment.rule.category);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(style.icon, size: 22, color: style.color),
        Text(
          '${daysBetween(today, payment.date)} gün',
          style: TextStyle(fontSize: 11, color: c.textMuted),
        ),
      ],
    );
  }
}
