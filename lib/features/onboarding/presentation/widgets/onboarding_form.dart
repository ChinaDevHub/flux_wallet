import 'package:flutter/material.dart';
import 'package:flux_wallet/features/onboarding/presentation/widgets/balance_row.dart';
import 'package:flux_wallet/features/onboarding/presentation/widgets/salary_row.dart';

class OnboardingForm extends StatelessWidget {
  const OnboardingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [BalanceRow(), SalaryRow()]);
  }
}
