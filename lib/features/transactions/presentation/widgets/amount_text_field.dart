import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/amount_input.dart';

/// Caption + the big centered number input.
class AmountTextField extends StatelessWidget {
  const AmountTextField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      children: [
        Text(
          'MƏBLƏĞ DAXİL EDİN',
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 0.8,
            color: c.textMuted,
          ),
        ),
        AmountInput(controller: controller, onChanged: onChanged),
      ],
    );
  }
}
