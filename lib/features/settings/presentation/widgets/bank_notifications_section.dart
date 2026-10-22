import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/notifications/presentation/pages/open_approval_page.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/settings_state.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_row.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_section.dart';

/// Notification access (Android only) and the approval queue.
class BankNotificationsSection extends StatelessWidget {
  const BankNotificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, s) => SettingsSection(
        title: 'Bank bildirişləri',
        children: [
          SettingsRow(
            icon: Icons.notifications_active_outlined,
            title: s.accessSupported ? 'Bildirişlərə giriş' : 'Avtomatik oxuma',
            subtitle: !s.accessSupported
                ? 'iOS başqa tətbiqlərin bildirişlərini oxumağa icazə vermir'
                : s.accessGranted
                ? 'Aktivdir'
                : 'Söndürülüb · bank bildirişlərini oxumaq üçün icazə ver',
            onTap: s.accessSupported ? cubit.openAccess : null,
          ),
          SettingsRow(
            icon: Icons.fact_check_outlined,
            title: 'Təsdiq növbəsi',
            subtitle: s.pendingCount == 0
                ? 'Gözləyən yoxdur · bank mətnini əl ilə əlavə et'
                : '${s.pendingCount} bildiriş təsdiq gözləyir',
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => openApprovalPage(context),
          ),
        ],
      ),
    );
  }
}
