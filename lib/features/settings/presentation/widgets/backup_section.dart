import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/icons/action_icons.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/backup_actions.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_row.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_section.dart';

/// Everything lives on this phone only, so a file backup is the one way to
/// keep the data across a new phone or a reinstall.
class BackupSection extends StatelessWidget {
  const BackupSection({super.key});

  @override
  Widget build(BuildContext context) {
    final backup = context.read<SettingsCubit>().backup;
    return SettingsSection(
      title: 'Ehtiyat nüsxə',
      footer:
          'Məlumatların yalnız bu telefonda saxlanılır. Telefonu dəyişəndə '
          'və ya tətbiqi silib yenidən quranda geri qaytarmağın yolu '
          'ehtiyat nüsxədir.',
      children: [
        SettingsRow(
          icon: ActionIcons.exportFile,
          title: 'Ehtiyat nüsxə yarat',
          subtitle: 'Məlumatları fayl kimi saxla və ya paylaş',
          onTap: () => runExport(context, backup),
        ),
        SettingsRow(
          icon: ActionIcons.importFile,
          title: 'Nüsxədən bərpa et',
          subtitle: 'Əvvəl yaratdığın fayldan geri qaytar',
          onTap: () => runImport(context, backup),
        ),
      ],
    );
  }
}
