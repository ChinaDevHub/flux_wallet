import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/core/widgets/amount_decoration.dart';

/// The number plus the currency sign right next to it (not at the far edge).
class AmountInput extends StatelessWidget {
  const AmountInput({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 6,
      children: [
        IntrinsicWidth(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 90),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              textAlign: TextAlign.center,
              keyboardType: amountKeyboard,
              inputFormatters: amountFormatters,
              style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.w800,
                color: c.text,
              ),
              decoration: amountDecoration(c),
            ),
          ),
        ),
        Text(azn, style: TextStyle(fontSize: 28, color: c.textMuted)),
      ],
    );
  }
}
