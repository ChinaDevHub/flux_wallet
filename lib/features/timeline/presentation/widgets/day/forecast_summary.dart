import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';

/// A day that has not come: what is planned and the balance after it.
class ForecastSummary extends StatelessWidget {
  const ForecastSummary({super.key, required this.day});

  final TimelineDay day;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final planned = day.entries
        .where((e) => e.counts)
        .fold(0.0, (sum, e) => sum + e.signedAmount);
    final low = day.endBalance < 0;
    Widget stat(String label, String value, Color color) => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: c.textMuted)),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w800, color: color),
          ),
        ],
      ),
    );
    return Row(
      children: [
        stat('Planlı', formatAzn(planned, signed: true), c.text),
        stat(
          'Gün sonu balans',
          formatAzn(day.endBalance),
          low ? c.negative : c.text,
        ),
      ],
    );
  }
}
