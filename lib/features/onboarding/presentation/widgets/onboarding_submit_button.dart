import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/primary_button.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/onboarding_state.dart';

class OnboardingSubmitButton extends StatelessWidget {
  const OnboardingSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, s) => PrimaryButton(
        label: 'Davam et',
        loading: s.status == OnboardingStatus.saving,
        onPressed: s.canSubmit ? context.read<OnboardingCubit>().submit : null,
      ),
    );
  }
}
