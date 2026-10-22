import 'package:flutter/material.dart';
import 'package:flux_wallet/app_boot.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/auth/domain/usecases/resolve_session.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/session_cubit.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/theme_cubit.dart';

/// The app-wide cubits, starting from what was read at boot. Without a boot
/// value (it failed, or in tests) they load it themselves.
extension AppBootCubits on AppBoot {
  SessionCubit sessionCubit(AppDependencies deps) {
    final cubit = SessionCubit(
      deps.useCases.resolveSession,
      deps.changes,
      initial: session ?? SessionState.loading,
    );
    return session == null ? (cubit..load()) : cubit;
  }

  ThemeCubit themeCubit(AppDependencies deps) {
    final cubit = ThemeCubit(
      deps.repos.settings,
      deps.changes,
      initial: themeMode ?? ThemeMode.system,
    );
    return themeMode == null ? (cubit..load()) : cubit;
  }
}
