import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debts_overview.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_total_tile.dart';

/// "Borcum" and "Mənə borcludurlar" at a glance.
class DebtsTotals extends StatelessWidget {
  const DebtsTotals(this.overview, {super.key});

  final DebtsOverview overview;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      spacing: 12,
      children: [
        DebtTotalTile(
          'Borcum',
          overview.total(DebtDirection.borrowed),
          c.accent,
        ),
        DebtTotalTile(
          'Mənə borcludurlar',
          overview.total(DebtDirection.lent),
          c.positive,
        ),
      ],
    );
  }
}
