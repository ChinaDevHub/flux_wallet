import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/security/presentation/cubit/app_lock_cubit.dart';

/// Feeds the app's foreground/background changes to the [AppLockCubit].
class AppLockLifecycle extends StatefulWidget {
  const AppLockLifecycle({super.key, required this.child});

  final Widget child;

  @override
  State<AppLockLifecycle> createState() => _AppLockLifecycleState();
}

class _AppLockLifecycleState extends State<AppLockLifecycle> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    final lock = context.read<AppLockCubit>();
    _listener = AppLifecycleListener(
      onInactive: lock.inactive,
      onHide: lock.hidden,
      onResume: lock.shown,
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
