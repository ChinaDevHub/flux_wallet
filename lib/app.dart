import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/app_boot.dart';
import 'package:flux_wallet/app_cubits.dart';
import 'package:flux_wallet/app_gate.dart';
import 'package:flux_wallet/app_view.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/session_cubit.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/theme_cubit.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_gate.dart';

class FluxWalletApp extends StatelessWidget {
  const FluxWalletApp({
    super.key,
    required this.deps,
    this.boot = const AppBoot(),
    this.onRevealed,
  });

  final AppDependencies deps;
  final AppBoot boot; // read before the first frame (nothing in tests)
  final VoidCallback? onRevealed; // splash gone: heavy, non-urgent work

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: deps,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SessionCubit>(create: (_) => boot.sessionCubit(deps)),
          BlocProvider<ThemeCubit>(create: (_) => boot.themeCubit(deps)),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (_, mode) => AppView(
            mode: mode,
            home: SplashGate(
              onRevealed: onRevealed,
              child: AppGate(deps: deps),
            ),
          ),
        ),
      ),
    );
  }
}
