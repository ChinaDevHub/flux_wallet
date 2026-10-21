import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/domain/entities/income_cycle.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/cycle_title.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/days_chip.dart';

/// "Növbəti gəlirə qədər" header with days left and a progress bar.
class IncomeCycleCard extends StatelessWidget {
  const IncomeCycleCard(this.cycle, {super.key});

  final IncomeCycle cycle;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: CycleTitle(cycle)),
              DaysChip('${cycle.daysLeft} gün qalıb'),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: cycle.progress,
              minHeight: 5,
              backgroundColor: c.surfaceAlt,
              valueColor: AlwaysStoppedAnimation(c.primary),
            ),
          ),
        ],
      ),
    );
  }
}
