import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/nav_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/settings/presentation/pages/open_settings_page.dart';

class HomeSettingsButton extends StatelessWidget {
  const HomeSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return IconButton.filledTonal(
      tooltip: 'Ayarlar',
      onPressed: () => openSettingsPage(context),
      style: IconButton.styleFrom(
        backgroundColor: c.surfaceAlt,
        foregroundColor: c.text,
        fixedSize: const Size(44, 44),
      ),
      icon: Icon(NavIcons.settings, size: 20),
    );
  }
}
