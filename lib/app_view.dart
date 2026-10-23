import 'package:flutter/material.dart';
import 'package:flux_wallet/core/alerts/alert_host.dart';
import 'package:flux_wallet/core/platform/system_ui_style.dart';
import 'package:flux_wallet/core/theme/app_theme.dart';
import 'package:flux_wallet/features/security/presentation/widgets/app_lock_host.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_gate.dart';

/// The `MaterialApp`: themes, and above every screen (the Navigator) the
/// PIN lock, then the splash, then the alert layer.
class AppView extends StatelessWidget {
  const AppView({
    super.key,
    required this.mode,
    required this.home,
    this.onRevealed,
  });

  final ThemeMode mode;
  final Widget home;
  final VoidCallback? onRevealed;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flux Wallet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: mode,
      builder: (_, child) => AlertHost(
        child: SystemUiStyle(
          child: SplashGate(
            onRevealed: onRevealed,
            child: AppLockHost(child: child!),
          ),
        ),
      ),
      home: home,
    );
  }
}
