import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/platform/app_switch.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/settings_result.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/settings_state.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_messages.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_row.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_section.dart';

/// "Axşam 21:00: Nağd xərcin oldumu?"
class ReminderSection extends StatelessWidget {
  const ReminderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    return SettingsSection(
      title: 'Xatırlatma',
      children: [
        BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (a, b) => a.reminderEnabled != b.reminderEnabled,
          builder: (context, s) => SettingsRow(
            icon: Icons.alarm_rounded,
            title: 'Axşam xatırlatması · 21:00',
            subtitle: '"Nağd xərcin oldumu?"',
            trailing: AppSwitch(
              value: s.reminderEnabled,
              onChanged: (on) async {
                final result = await cubit.setReminder(on);
                if (context.mounted && result != SettingsResult.done) {
                  showSettingsResult(context, result);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
