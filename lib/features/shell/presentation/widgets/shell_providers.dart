import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debts_cubit.dart';
import 'package:flux_wallet/features/home/presentation/cubit/home_cubit.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/notification_ingest_host.dart';
import 'package:flux_wallet/features/profile/presentation/pages/open_profile_page.dart';
import 'package:flux_wallet/features/shell/presentation/pages/main_shell.dart';
import 'package:flux_wallet/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_cubit.dart';

/// Tab cubits (alive all session) and the notification feed around the shell.
class ShellProviders extends StatelessWidget {
  const ShellProviders({super.key, required this.deps});

  final AppDependencies deps;

  @override
  Widget build(BuildContext context) {
    final u = deps.useCases;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => newProfileCubit(deps)..load()),
        BlocProvider(
          create: (_) => HomeCubit(u.loadHome, deps.changes)..load(),
        ),
        BlocProvider(
          create: (_) =>
              TimelineCubit(u.loadTimeline, u.scheduleEditor, deps.changes)
                ..load(),
        ),
        BlocProvider(create: (_) => newDebtsCubit(deps)),
        BlocProvider(
          create: (_) =>
              StatisticsCubit(u.loadStatistics, deps.changes)..load(),
        ),
      ],
      child: NotificationIngestHost(
        source: deps.notificationSource,
        ingest: u.ingest,
        child: const MainShell(),
      ),
    );
  }
}
