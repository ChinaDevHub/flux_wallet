import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/action_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/reset_data_action.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_section.dart';

/// The danger zone: wipe everything and start from zero.
class DataSection extends StatelessWidget {
  const DataSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SettingsSection(
      title: 'Məlumatlar',
      footer: 'Sıfırladıqdan sonra ilkin balansı yenidən daxil edəcəksən.',
      children: [
        InkWell(
          onTap: () => runResetData(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              spacing: 12,
              children: [
                Icon(ActionIcons.delete, color: c.negative),
                Expanded(
                  child: Text(
                    'Bütün datanı sıfırla',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: c.negative,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
