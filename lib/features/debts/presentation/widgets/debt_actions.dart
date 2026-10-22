import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/action_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// Delete, plus a pay button while the debt is still open ([onPay] != null).
class DebtActions extends StatelessWidget {
  const DebtActions({
    super.key,
    required this.onDelete,
    this.payLabel,
    this.onPay,
  });

  final String? payLabel;
  final VoidCallback? onPay;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        OutlinedButton(
          onPressed: onDelete,
          child: Icon(ActionIcons.delete, color: context.colors.negative),
        ),
        if (onPay != null)
          Expanded(
            child: FilledButton(onPressed: onPay, child: Text(payLabel!)),
          ),
      ],
    );
  }
}
