import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/auth/domain/usecases/resolve_session.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/session_cubit.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_layers.dart';

/// Plays the splash, builds [child] (sign-in or the app) underneath while the
/// logo is still, then lifts the splash: first launch lands on sign-in, later
/// ones on Home. [onRevealed] runs a little after, for heavy work that must
/// not compete with the animation.
class SplashGate extends StatefulWidget {
  const SplashGate({super.key, required this.child, this.onRevealed});

  final Widget child;
  final VoidCallback? onRevealed;

  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate> {
  bool _settled = false, _finished = false, _revealed = false;

  void _scheduleReveal() => Future<void>.delayed(
    const Duration(milliseconds: 1500),
    () => mounted ? widget.onRevealed?.call() : null,
  );

  @override
  Widget build(BuildContext context) {
    final known = context.select(
      (SessionCubit c) => c.state != SessionState.loading,
    );
    final leaving = _finished && known;
    if (leaving && !_revealed) {
      _revealed = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _scheduleReveal());
    }
    return SplashLayers(
      app: widget.child,
      showApp: _settled || leaving,
      leaving: leaving,
      onSettled: () => setState(() => _settled = true),
      onFinished: () => setState(() => _finished = true),
    );
  }
}
