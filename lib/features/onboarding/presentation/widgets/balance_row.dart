import 'package:flutter/material.dart';
import 'package:flux_wallet/features/onboarding/presentation/widgets/onboarding_field.dart';

class BalanceRow extends StatelessWidget {
  const BalanceRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      spacing: 14,
      children: [
        Expanded(
          child: OnboardingField(
            'card',
            'Kart balansı',
            hint: '0.00',
            money: true,
          ),
        ),
        Expanded(
          child: OnboardingField('cash', 'Nağd pul', hint: '0.00', money: true),
        ),
      ],
    );
  }
}
