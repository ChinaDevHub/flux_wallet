import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/editable_avatar.dart';

/// Big avatar (tap to change), name and @username.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.user,
    required this.onAvatarTap,
  });

  final User user;
  final VoidCallback onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      spacing: 4,
      children: [
        EditableAvatar(user: user, onTap: onAvatarTap),
        const SizedBox(height: 8),
        Text(
          user.fullName,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: c.text,
          ),
        ),
        Text('@${user.username}', style: TextStyle(color: c.textMuted)),
      ],
    );
  }
}
