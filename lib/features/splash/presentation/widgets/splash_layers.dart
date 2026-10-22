import 'package:flutter/material.dart';
import 'package:flux_wallet/features/splash/presentation/pages/splash_page.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_exit.dart';

/// The app (once [showApp]) with the splash on top until [leaving].
class SplashLayers extends StatelessWidget {
  const SplashLayers({
    super.key,
    required this.app,
    required this.showApp,
    required this.leaving,
    required this.onSettled,
    required this.onFinished,
  });

  final Widget app;
  final bool showApp, leaving;
  final VoidCallback onSettled, onFinished;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        showApp ? app : const SizedBox.shrink(),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 420),
          transitionBuilder: splashExit,
          child: leaving
              ? const SizedBox.shrink(key: ValueKey('gone'))
              : SplashPage(
                  key: const ValueKey('splash'),
                  onSettled: onSettled,
                  onFinished: onFinished,
                ),
        ),
      ],
    );
  }
}
