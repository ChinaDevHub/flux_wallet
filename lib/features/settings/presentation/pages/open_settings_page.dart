import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/backup_runner.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flux_wallet/features/settings/presentation/pages/settings_page.dart';

Future<void> openSettingsPage(BuildContext context) {
  final deps = context.read<AppDependencies>();
  final u = deps.useCases;
  return Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (_) => SettingsCubit(
          reminder: u.eveningReminder,
          source: deps.notificationSource,
          pending: deps.repos.pending,
          backup: BackupRunner(u.exportBackup, u.importBackup),
          changes: deps.changes,
        )..load(),
        child: const SettingsPage(),
      ),
    ),
  );
}
