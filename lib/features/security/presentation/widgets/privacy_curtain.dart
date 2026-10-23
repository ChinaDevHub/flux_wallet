import 'package:flutter/material.dart';
import 'package:flux_wallet/core/branding/brand_colors.dart';
import 'package:flux_wallet/core/widgets/app_logo.dart';

/// What the app switcher snapshot shows instead of the balance.
class PrivacyCurtain extends StatelessWidget {
  const PrivacyCurtain({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(gradient: brandGradient),
      child: Center(child: AppLogo(size: 84)),
    );
  }
}
