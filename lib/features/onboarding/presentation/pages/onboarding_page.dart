import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/session_cubit.dart';
import 'package:flux_wallet/features/onboarding/presentation/widgets/onboarding_form.dart';
import 'package:flux_wallet/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:flux_wallet/features/onboarding/presentation/widgets/onboarding_submit_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  void _onState(BuildContext context, OnboardingState s) {
    if (s.status == OnboardingStatus.done) {
      context.read<SessionCubit>().check();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Yadda saxlamaq alınmadı. Yenidən cəhd et'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (_, s) =>
          s.status == OnboardingStatus.done ||
          s.status == OnboardingStatus.failure,
      listener: _onState,
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
            ],
          ),
        ),
      ),
    );
  }
}
