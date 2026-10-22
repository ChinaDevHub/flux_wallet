import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/widgets/app_logo.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppLogo(),
        const SizedBox(height: 24),
        Text(
          'Flux Wallet-a xoş gəldin',
          style: TextStyle(
            fontSize: 28,
            height: 1.15,
            fontWeight: FontWeight.w800,
            color: c.text,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Maaşa qədər hər gün nə qədər xərcləyə biləcəyini hesablayırıq. '
          'Məlumatlar yalnız bu cihazda saxlanılır.',
          style: TextStyle(fontSize: 15, height: 1.4, color: c.textMuted),
        ),
      ],
    );
  }
}
