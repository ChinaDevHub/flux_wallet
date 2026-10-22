import 'package:flutter/material.dart';
import 'package:flux_wallet/features/onboarding/presentation/widgets/onboarding_form.dart';
import 'package:flux_wallet/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:flux_wallet/features/onboarding/presentation/widgets/onboarding_listener.dart';
import 'package:flux_wallet/features/onboarding/presentation/widgets/onboarding_submit_button.dart';
import 'package:flux_wallet/features/onboarding/presentation/widgets/restore_backup_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingListener(
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: const [
              OnboardingHeader(),
              SizedBox(height: 32),
              OnboardingForm(),
              SizedBox(height: 10),
              OnboardingSubmitButton(),
              RestoreBackupButton(),
            ],
          ),
        ),
      ),
    );
  }
}
