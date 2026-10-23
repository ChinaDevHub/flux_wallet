import 'package:flutter/material.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/core/files/app_files.dart';
import 'package:flux_wallet/features/auth/domain/usecases/resolve_session.dart';
import 'package:flux_wallet/features/settings/domain/entities/setting_keys.dart';

/// Everything the first frame needs, read while the native launch screen
/// (which looks like the splash) is still up, so nothing loads, rebuilds or
/// re-themes while the splash animates. Any failure falls back to the
/// cubits' own loading.
class AppBoot {
  const AppBoot({this.session, this.themeMode, this.lockAtStart = false});

  final SessionState? session;
  final ThemeMode? themeMode;

  /// A signed-in user with a PIN starts behind the lock screen.
  final bool lockAtStart;

  static Future<AppBoot> load(AppDependencies deps) async {
    try {
      final results = await Future.wait<Object?>([
        AppFiles.init(),
        deps.useCases.resolveSession(),
        deps.repos.settings.read(SettingKeys.themeMode),
      ]);
      final saved = results[2] as String?;
      final session = results[1] as SessionState;
      return AppBoot(
        session: session,
        themeMode: ThemeMode.values.asNameMap()[saved] ?? ThemeMode.system,
        lockAtStart:
            session == SessionState.ready && await deps.useCases.appPin.isSet(),
      );
    } catch (_) {
      return const AppBoot();
    }
  }
}
