import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';

/// "+1,200.00 ₼" in green, "-4.80 ₼" in the text colour, or muted.
class SignedAmount extends StatelessWidget {
  const SignedAmount(this.value, {super.key, this.muted = false});

  final double value;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Text(
      formatAzn(value, signed: true),
      style: TextStyle(
        fontWeight: FontWeight.w800,
        color: muted
            ? c.textMuted
            : value > 0
            ? c.positive
            : c.text,
      ),
    );
  }
}
