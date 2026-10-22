import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/statistics/domain/entities/month_totals.dart';

class MonthSummary extends StatelessWidget {
  const MonthSummary(this.totals, {super.key});

  final MonthTotals totals;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    Widget stat(String label, String value, Color color) => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 11, color: c.textMuted)),
          FittedBox(
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.w800, color: color),
            ),
          ),
        ],
      ),
    );
    return Row(
      children: [
        stat('Gəlir', formatAzn(totals.income), c.positive),
        stat('Xərc', formatAzn(totals.expense), c.accent),
        stat(
          'Fərq',
          formatAzn(totals.net, signed: true),
          totals.net < 0 ? c.negative : c.text,
        ),
      ],
    );
  }
}
