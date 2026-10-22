import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_segmented.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/widgets/amount_text_field.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/payment_controller.dart';

/// Amount, the "Hamısı" shortcut and Kart / Nağd.
class PaymentInputs extends StatelessWidget {
  const PaymentInputs(this.controller, {super.key});

  final PaymentController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        AmountTextField(
          controller: controller.text,
          onChanged: (_) => controller.changed(),
        ),
        ActionChip(
          label: const Text('Hamısı'),
          backgroundColor: context.colors.surfaceAlt,
          onPressed: controller.fillAll,
        ),
        AdaptiveSegmented<int>(
          selected: controller.accountId,
          onChanged: controller.selectAccount,
          options: {for (final a in controller.accounts) a.id!: a.name},
        ),
      ],
    );
  }
}
