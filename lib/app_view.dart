import 'package:flutter/material.dart';
import 'package:flux_wallet/core/alerts/alert_host.dart';
import 'package:flux_wallet/core/platform/system_ui_style.dart';
import 'package:flux_wallet/core/theme/app_theme.dart';

/// The `MaterialApp`: themes, and the alert layer above every screen.
class AppView extends StatelessWidget {
  const AppView({super.key, required this.mode, required this.home});

  final ThemeMode mode;
  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flux Wallet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: mode,
      builder: (_, child) => AlertHost(child: SystemUiStyle(child: child!)),
      home: home,
    );
  }
}
