import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/statistics/domain/entities/statistics_view.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/range_label.dart';

/// What the numbers below add up: the whole period, or the one month that
/// was tapped (with a way back to the whole period).
class SummaryCaption extends StatelessWidget {
  const SummaryCaption({super.key, required this.view, required this.onAll});

  final StatisticsView view;
  final VoidCallback onAll;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final pick = view.selected;
    return Row(
      children: [
        Expanded(
          child: Text(
            pick == null
                ? 'Bütün dövr · ${rangeLabel(view.range)}'
                : monthLabel(pick),
            style: TextStyle(fontSize: 12, color: c.textMuted),
          ),
        ),
        if (pick != null)
          TextButton(onPressed: onAll, child: const Text('Bütün dövr')),
      ],
    );
  }
}
