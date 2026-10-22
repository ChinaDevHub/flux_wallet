import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/account_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/widgets/sheet_heading.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/avatar_preset_grid.dart';

/// Choose one of the built-in avatars, or a photo from the gallery.
class AvatarPickerSheet extends StatelessWidget {
  const AvatarPickerSheet({
    super.key,
    required this.onPreset,
    required this.onGallery,
  });

  final ValueChanged<int> onPreset;
  final VoidCallback onGallery;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          const SheetHeading('Profil şəkli'),
          AvatarPresetGrid(onPreset: onPreset),
          OutlinedButton.icon(
            onPressed: onGallery,
            icon: Icon(AccountIcons.gallery, color: c.primary),
            label: const Text('Qalereyadan seç'),
          ),
        ],
      ),
    );
  }
}
