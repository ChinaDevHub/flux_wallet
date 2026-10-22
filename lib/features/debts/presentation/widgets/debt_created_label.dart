import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/az_calendar.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';

/// When the money changed hands: "Alındı · 19 Oktyabr" / "Verildi · ...".
class DebtCreatedLabel extends StatelessWidget {
  const DebtCreatedLabel(this.summary, {super.key});

  final DebtSummary summary;

  @override
  Widget build(BuildContext context) {
    final lent = summary.debt.direction == DebtDirection.lent;
    return Text(
      '${lent ? 'Verildi' : 'Alındı'} · ${azDayMonth(summary.debt.createdAt)}',
      style: TextStyle(fontSize: 12, color: context.colors.textMuted),
    );
  }
}
