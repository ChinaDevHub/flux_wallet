import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';

class DonutCenter extends StatelessWidget {
  const DonutCenter(this.total, {super.key});

  final double total;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Cəmi xərc', style: TextStyle(fontSize: 11, color: c.textMuted)),
        Text(
          formatAzn(total),
          style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
        ),
      ],
    );
  }
}
