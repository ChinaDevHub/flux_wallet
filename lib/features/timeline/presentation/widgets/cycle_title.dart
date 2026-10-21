import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/az_calendar.dart';
import 'package:flux_wallet/features/timeline/domain/entities/income_cycle.dart';

class CycleTitle extends StatelessWidget {
  const CycleTitle(this.cycle, {super.key});

  final IncomeCycle cycle;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NÖVBƏTİ GƏLİRƏ QƏDƏR',
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 0.6,
            color: c.textMuted,
          ),
        ),
        Text(
          '${azDayMonth(cycle.date)} — ${cycle.title} günü',
          style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
        ),
      ],
    );
  }
}
