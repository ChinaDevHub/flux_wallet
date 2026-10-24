import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';
import 'package:flux_wallet/features/home/domain/entities/limit_status.dart';
import 'package:flux_wallet/features/home/presentation/widgets/limit_status_style.dart';
import 'package:flux_wallet/features/home/presentation/widgets/limit_card_decoration.dart';
import 'package:flux_wallet/features/home/presentation/widgets/limit_card_header.dart';
import 'package:flux_wallet/features/home/presentation/widgets/limit_hero_amount.dart';
import 'package:flux_wallet/features/home/presentation/widgets/limit_progress.dart';
import 'package:flux_wallet/features/home/presentation/widgets/limit_stats_row.dart';

class LimitCard extends StatelessWidget {
  const LimitCard({super.key, required this.snapshot});

  final HomeSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final s = snapshot;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: limitCardDecoration(c),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LimitCardHeader(s),
          const SizedBox(height: 10),
          LimitHeroAmount(remaining: s.remainingToday, budget: s.dailyBudget),
          const SizedBox(height: 18),
          LimitProgress(
            ratio: s.remainingRatio,
            spent: s.spentToday,
            color: s.status.barColor,
          ),
          const SizedBox(height: 18),
          LimitStatsRow(limit: s.limit),
        ],
      ),
    );
  }
}
