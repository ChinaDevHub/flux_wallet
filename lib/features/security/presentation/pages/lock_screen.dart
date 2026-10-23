import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/security/presentation/cubit/app_lock_cubit.dart';
import 'package:flux_wallet/features/security/presentation/cubit/unlock_cubit.dart';
import 'package:flux_wallet/features/security/presentation/pages/lock_screen_body.dart';

/// The full-screen PIN gate. Not a route: it lives above the Navigator.
class LockScreen extends StatelessWidget {
  const LockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deps = context.read<AppDependencies>();
    final lock = context.read<AppLockCubit>();
    return BlocProvider(
      create: (_) => UnlockCubit(
        deps.useCases.appPin,
        deps.clock,
        onUnlocked: () {
          HapticFeedback.mediumImpact();
          lock.unlock();
        },
      ),
      child: const LockScreenBody(),
    );
  }
}
