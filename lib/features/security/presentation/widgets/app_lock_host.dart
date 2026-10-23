import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/security/presentation/cubit/app_lock_cubit.dart';
import 'package:flux_wallet/features/security/presentation/cubit/app_lock_state.dart';
import 'package:flux_wallet/features/security/presentation/pages/lock_screen.dart';
import 'package:flux_wallet/features/security/presentation/widgets/app_lock_lifecycle.dart';
import 'package:flux_wallet/features/security/presentation/widgets/privacy_curtain.dart';

/// Sits above the Navigator: the lock screen and the privacy curtain cover
/// every page, sheet and dialog, and the app underneath keeps its state.
class AppLockHost extends StatelessWidget {
  const AppLockHost({super.key, required this.child});

  final Widget child;

  Widget _transition(Widget w, Animation<double> a) => FadeTransition(
    opacity: a,
    child: ScaleTransition(
      scale: Tween(begin: 1.04, end: 1.0).animate(a),
      child: w,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AppLockLifecycle(
      child: BlocBuilder<AppLockCubit, AppLockState>(
        buildWhen: (a, b) => a.locked != b.locked || a.curtain != b.curtain,
        builder: (_, s) => Stack(
          fit: StackFit.expand,
          children: [
            child,
            if (s.curtain) const PrivacyCurtain(),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 320),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: _transition,
              child: s.locked
                  ? const LockScreen(key: ValueKey('locked'))
                  : const SizedBox.shrink(key: ValueKey('open')),
            ),
          ],
        ),
      ),
    );
  }
}
