import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/session_cubit.dart';

/// Leaves onboarding when saving worked, tells the user when it did not.
class OnboardingListener extends StatelessWidget {
  const OnboardingListener({super.key, required this.child});

  final Widget child;

  void _onState(BuildContext context, OnboardingState s) {
    if (s.status == OnboardingStatus.done) {
      context.read<SessionCubit>().load();
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
      child: child,
    );
  }
}
