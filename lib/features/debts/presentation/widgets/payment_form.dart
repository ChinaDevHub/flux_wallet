import 'package:flutter/material.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/core/widgets/primary_button.dart';
import 'package:flux_wallet/core/widgets/sheet_heading.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/payment_controller.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/payment_inputs.dart';

/// The payment sheet's contents, driven by a [PaymentController].
class PaymentForm extends StatelessWidget {
  const PaymentForm({
    super.key,
    required this.summary,
    required this.controller,
    required this.onSubmit,
  });

  final DebtSummary summary;
  final PaymentController controller;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final lent = summary.debt.direction == DebtDirection.lent;
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          SheetHeading(
            '${summary.debt.person} · ${lent ? 'qaytarılan' : 'ödəniş'}',
            description: 'Qalıq: ${formatAzn(summary.remaining)}',
          ),
          PaymentInputs(controller),
          PrimaryButton(
            label: lent ? 'Qəbul et' : 'Ödə',
            onPressed: controller.isValid ? onSubmit : null,
          ),
        ],
      ),
    );
  }
}
