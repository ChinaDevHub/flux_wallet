import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_created_label.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_due_label.dart';

/// Person, due date and the amount still open.
class DebtCardHeader extends StatelessWidget {
  const DebtCardHeader(this.summary, this.today, {super.key});

  final DebtSummary summary;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lent = summary.debt.direction == DebtDirection.lent;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                summary.debt.person,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: c.text,
                ),
              ),
              DebtDueLabel(summary, today),
              DebtCreatedLabel(summary),
            ],
          ),
        ),
        Text(
          formatAzn(
            lent ? summary.remaining : -summary.remaining,
            signed: true,
          ),
          style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
        ),
      ],
    );
  }
}
