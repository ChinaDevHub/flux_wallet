import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';

/// Right side of a day card: caption + the balance at the end of the day.
class DayForecast extends StatelessWidget {
  const DayForecast({super.key, required this.caption, required this.balance});

  final String caption;
  final double balance;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(caption, style: TextStyle(fontSize: 10, color: c.textMuted)),
        Text(
          formatAzn(balance),
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: balance < 0 ? c.negative : c.text,
          ),
        ),
      ],
    );
  }
}
