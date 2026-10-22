import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_card_header.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_progress.dart';

class DebtCard extends StatelessWidget {
  const DebtCard({
    super.key,
    required this.summary,
    required this.today,
    required this.actions,
  });

  final DebtSummary summary;
  final DateTime today;
  final Widget actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          DebtCardHeader(summary, today),
          DebtProgress(summary),
          actions,
        ],
      ),
    );
  }
}
