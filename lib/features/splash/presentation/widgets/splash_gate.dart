import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/auth/domain/usecases/resolve_session.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/session_cubit.dart';
import 'package:flux_wallet/features/splash/presentation/pages/splash_page.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_exit.dart';

/// Plays the splash, builds [child] (sign-in or the app) underneath as soon
/// as the logo has landed, and lifts the splash once the animation is over
/// and the session is known: first launch lands on sign-in, later ones on Home.
class SplashGate extends StatefulWidget {
  const SplashGate({super.key, required this.child});

  final Widget child;

  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate> {
  bool _settled = false, _finished = false;

  @override
  Widget build(BuildContext context) {
    final known = context.select(
      (SessionCubit c) => c.state != SessionState.loading,
    );
    final leaving = _finished && known;
    return Stack(
      fit: StackFit.expand,
      children: [
        _settled || leaving ? widget.child : const SizedBox.shrink(),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 420),
          transitionBuilder: splashExit,
          child: leaving
              ? const SizedBox.shrink(key: ValueKey('gone'))
              : SplashPage(
                  key: const ValueKey('splash'),
                  onSettled: () => setState(() => _settled = true),
                  onFinished: () => setState(() => _finished = true),
                ),
        ),
      ],
    );
  }
}
