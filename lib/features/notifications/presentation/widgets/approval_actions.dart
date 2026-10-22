import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

class ApprovalActions extends StatelessWidget {
  const ApprovalActions({
    super.key,
    required this.canConfirm,
    required this.onConfirm,
    required this.onDismiss,
  });

  final bool canConfirm;
  final VoidCallback onConfirm, onDismiss;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      spacing: 10,
      children: [
        OutlinedButton.icon(
          onPressed: onDismiss,
          icon: Icon(Icons.delete_outline_rounded, color: c.negative),
          label: Text('Sil', style: TextStyle(color: c.negative)),
        ),
        Expanded(
          child: FilledButton.icon(
            onPressed: canConfirm ? onConfirm : null,
            icon: const Icon(Icons.check_rounded),
            label: const Text('Təsdiqlə'),
          ),
        ),
      ],
    );
  }
}
