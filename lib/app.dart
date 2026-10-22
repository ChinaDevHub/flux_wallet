import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/app_gate.dart';
import 'package:flux_wallet/core/alerts/alert_host.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/core/platform/system_ui_style.dart';
import 'package:flux_wallet/core/theme/app_theme.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/session_cubit.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_gate.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/theme_cubit.dart';

class FluxWalletApp extends StatelessWidget {
  const FluxWalletApp({super.key, required this.deps});

  final AppDependencies deps;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: deps,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                SessionCubit(deps.useCases.resolveSession, deps.changes)
                  ..load(),
          ),
          BlocProvider(
            create: (_) =>
                ThemeCubit(deps.repos.settings, deps.changes)..load(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (_, mode) => MaterialApp(
            title: 'Flux Wallet',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: mode,
            builder: (_, child) =>
                AlertHost(child: SystemUiStyle(child: child!)),
            home: SplashGate(child: AppGate(deps: deps)),
          ),
        ),
      ),
    );
  }
}
