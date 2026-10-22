import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/announce_queued.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/notification_ingest_host.dart';
import 'package:flux_wallet/features/shell/presentation/pages/main_shell.dart';
import 'package:flux_wallet/features/shell/presentation/widgets/shell_cubits.dart';

/// Tab cubits (alive all session) and the notification feed around the shell.
class ShellProviders extends StatelessWidget {
  const ShellProviders({super.key, required this.deps});

  final AppDependencies deps;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: shellCubits(deps),
      child: NotificationIngestHost(
        source: deps.notificationSource,
        ingest: deps.useCases.ingest,
        onQueued: () => announceQueued(context),
        child: const MainShell(),
      ),
    );
  }
}
