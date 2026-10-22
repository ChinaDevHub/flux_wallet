import 'package:flutter/material.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/payment_controller.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/payment_form.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';

/// Enter how much of the debt was just paid (or returned to me).
class PaymentSheet extends StatefulWidget {
  const PaymentSheet({
    super.key,
    required this.summary,
    required this.accounts,
    required this.onPay,
  });

  final DebtSummary summary;
  final List<Account> accounts;
  final void Function(double amount, int accountId) onPay;

  @override
  State<PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet> {
  late final _controller = PaymentController(
    accounts: widget.accounts,
    remaining: widget.summary.remaining,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: PaymentForm(
        summary: widget.summary,
        controller: _controller,
        onSubmit: () {
          Navigator.pop(context);
          widget.onPay(_controller.amount, _controller.accountId);
        },
      ),
    );
  }
}
