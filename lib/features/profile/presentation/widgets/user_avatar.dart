import 'package:flutter/material.dart';
import 'package:flux_wallet/core/files/app_files.dart';
import 'package:flux_wallet/features/profile/domain/entities/avatar.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/avatar_presets.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/initials_avatar.dart';

/// A preset, a picked photo, or the initials as a fallback.
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.avatarUrl,
    required this.fullName,
    this.radius = 18,
  });

  final String? avatarUrl;
  final String fullName;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final index = Avatar.presetIndex(avatarUrl);
    if (index != null && index >= 0 && index < avatarPresets.length) {
      final (icon, color) = avatarPresets[index];
      return CircleAvatar(
        radius: radius,
        backgroundColor: color,
        child: Icon(icon, size: radius * 1.1, color: Colors.white),
      );
    }
    final name = Avatar.fileName(avatarUrl);
    final file = name == null ? null : AppFiles.avatar(name);
    if (file != null && file.existsSync()) {
      return CircleAvatar(radius: radius, backgroundImage: FileImage(file));
    }
    return InitialsAvatar(fullName: fullName, radius: radius);
  }
}
