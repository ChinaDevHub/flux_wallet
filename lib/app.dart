import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/app_gate.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/core/platform/system_ui_style.dart';
import 'package:flux_wallet/core/theme/app_theme.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/session_cubit.dart';

class FluxWalletApp extends StatelessWidget {
  const FluxWalletApp({super.key, required this.deps});

  final AppDependencies deps;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: deps,
      child: BlocProvider(
        create: (_) => SessionCubit(deps.profile)..check(),
        child: MaterialApp(
          title: 'Flux Wallet',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          builder: (_, child) => SystemUiStyle(child: child!),
          home: AppGate(deps: deps),
        ),
      ),
    );
  }
}
