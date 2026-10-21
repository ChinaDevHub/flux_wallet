import 'package:flutter/material.dart';
import 'package:flux_wallet/features/onboarding/presentation/widgets/onboarding_field.dart';

class SalaryRow extends StatelessWidget {
  const SalaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      spacing: 14,
      children: [
        Expanded(
          flex: 3,
          child: OnboardingField(
            'salary',
            'Aylıq gəlir',
            hint: 'Maaş',
            money: true,
          ),
        ),
        Expanded(
          flex: 2,
          child: OnboardingField('salaryDay', 'Gün', hint: '1-31', day: true),
        ),
      ],
    );
  }
}
