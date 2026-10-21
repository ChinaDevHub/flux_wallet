import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Keeps status/navigation bar icons readable in light and dark mode.
class SystemUiStyle extends StatelessWidget {
  const SystemUiStyle({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final icons = dark ? Brightness.light : Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: icons,
        statusBarBrightness: dark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: icons,
      ),
      child: child,
    );
  }
}
