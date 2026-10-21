import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/az_calendar.dart';
import 'package:flux_wallet/features/rules/domain/entities/planned_payment.dart';
import 'package:flux_wallet/features/home/presentation/widgets/upcoming_amount.dart';
import 'package:flux_wallet/features/home/presentation/widgets/upcoming_card_header.dart';

class UpcomingCard extends StatelessWidget {
  const UpcomingCard({super.key, required this.payment, required this.today});

  final PlannedPayment payment;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: 140,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UpcomingCardHeader(payment, today),
          const Spacer(),
          Text(
            payment.rule.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
          ),
          Text(
            azDayMonth(payment.date),
            style: TextStyle(fontSize: 11, color: c.textMuted),
          ),
          const SizedBox(height: 8),
          UpcomingAmount(payment.rule),
        ],
      ),
    );
  }
}
