import 'package:flutter/material.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/avatar_presets.dart';

/// The built-in avatars; tapping one reports its index.
class AvatarPresetGrid extends StatelessWidget {
  const AvatarPresetGrid({super.key, required this.onPreset});

  final ValueChanged<int> onPreset;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        for (var i = 0; i < avatarPresets.length; i++)
          InkResponse(
            onTap: () => onPreset(i),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: avatarPresets[i].$2,
              child: Icon(avatarPresets[i].$1, color: Colors.white),
            ),
          ),
      ],
    );
  }
}
