import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/auth/domain/usecases/resolve_session.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/session_cubit.dart';
import 'package:flux_wallet/features/auth/presentation/pages/auth_page.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flux_wallet/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flux_wallet/features/shell/presentation/widgets/shell_providers.dart';

/// Signed out: sign-in. Signed in without data: first-time setup. Otherwise
/// the app. Leaving "ready" disposes every screen cubit, so one user's state
/// can never leak into the next user's session.
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
          SessionState.signedOut => const AuthPage(key: ValueKey('auth')),
          SessionState.onboarding => BlocProvider(
            key: const ValueKey('onboarding'),
            create: (_) => OnboardingCubit(deps.repos.onboarding, deps.clock),
            child: const OnboardingPage(),
          ),
          SessionState.ready => ShellProviders(
            key: const ValueKey('home'),
            deps: deps,
          ),
        },
      ),
    );
  }
}
