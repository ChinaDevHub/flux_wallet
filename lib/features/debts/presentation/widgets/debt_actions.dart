import 'package:flutter/material.dart';

/// The pay button, while the debt is still open. Edit and delete are the
/// swipe / long-press actions of the card, as on every other list.
class DebtActions extends StatelessWidget {
  const DebtActions({super.key, this.payLabel, this.onPay});

  final String? payLabel;
  final VoidCallback? onPay;

  @override
  Widget build(BuildContext context) {
    if (onPay == null) return const SizedBox.shrink();
    return SizedBox(
      width: double.infinity,
      child: FilledButton(onPressed: onPay, child: Text(payLabel!)),
    );
  }
}
