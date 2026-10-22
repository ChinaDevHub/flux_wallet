import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/backup_runner.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/settings_result.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/confirm_import.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_messages.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_row.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_section.dart';

/// JSON export / import, so nothing is lost when the phone changes.
class BackupSection extends StatelessWidget {
  const BackupSection({super.key});

  Future<void> _export(BuildContext context, BackupRunner backup) async {
    final result = await backup.export();
    if (context.mounted && result != SettingsResult.done) {
      showSettingsResult(context, result);
    }
  }

  Future<void> _import(BuildContext context, BackupRunner backup) async {
    if (!await confirmImport(context)) return;
    final result = await backup.import();
    if (context.mounted) showSettingsResult(context, result);
  }

  @override
  Widget build(BuildContext context) {
    final backup = context.read<SettingsCubit>().backup;
    return SettingsSection(
      title: 'Məlumatlar',
      children: [
        SettingsRow(
          icon: Icons.upload_file_rounded,
          title: 'İxrac et (JSON)',
          subtitle: 'Bütün məlumatları fayl kimi saxla və ya paylaş',
          onTap: () => _export(context, backup),
        ),
        SettingsRow(
          icon: Icons.download_rounded,
          title: 'İdxal et',
          subtitle: 'Əvvəlki ixracdan məlumatları bərpa et',
          onTap: () => _import(context, backup),
        ),
      ],
    );
  }
}
