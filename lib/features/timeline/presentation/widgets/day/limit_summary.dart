import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/timeline/domain/entities/day_limit.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/limit_bar.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/over_limit_note.dart';

/// Spent against the limit of a day that has come (today or earlier).
class LimitSummary extends StatelessWidget {
  const LimitSummary({super.key, required this.limit, required this.isToday});

  final DayLimit limit;
  final bool isToday;

  String get _caption {
    if (limit.spent <= 0) return 'Bu gün xərc olmayıb';
    return isToday
        ? '${formatAzn(limit.budget - limit.spent)} qalıb'
        : 'Limit daxilində';
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Row(
          children: [
            Text('Xərc', style: TextStyle(color: c.textMuted)),
            const Spacer(),
            Text(
              '${formatAzn(limit.spent)} / ${formatAzn(limit.budget)}',
              style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
            ),
          ],
        ),
        LimitBar(used: limit.used, over: limit.isOver),
        if (limit.isOver)
          OverLimitNote(over: limit.over)
        else
          Text(_caption, style: TextStyle(fontSize: 12, color: c.textMuted)),
      ],
    );
  }
}
