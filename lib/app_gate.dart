import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/home/presentation/cubit/home_cubit.dart';
import 'package:flux_wallet/features/home/presentation/pages/home_page.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/session_cubit.dart';
import 'package:flux_wallet/features/onboarding/presentation/pages/onboarding_page.dart';

/// Shows onboarding until a profile exists, then the home screen.
class AppGate extends StatelessWidget {
  const AppGate({super.key, required this.deps});

  final AppDependencies deps;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, session) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        child: switch (session) {
          SessionState.loading => const Scaffold(key: ValueKey('loading')),
          SessionState.onboarding => BlocProvider(
            key: const ValueKey('onboarding'),
            create: (_) => OnboardingCubit(deps.profile, deps.clock),
            child: const OnboardingPage(),
          ),
          SessionState.ready => BlocProvider(
            key: const ValueKey('home'),
            create: (_) => HomeCubit(deps.loadHome)..load(),
            child: const HomePage(),
          ),
        },
      ),
    );
  }
}
