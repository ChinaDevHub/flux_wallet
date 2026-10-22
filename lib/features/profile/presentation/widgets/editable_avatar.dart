import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/user_avatar.dart';

/// The user's avatar with a small pencil badge; tap to change it.
class EditableAvatar extends StatelessWidget {
  const EditableAvatar({super.key, required this.user, required this.onTap});

  final User user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          UserAvatar(
            avatarUrl: user.avatarUrl,
            fullName: user.fullName,
            radius: 48,
          ),
          CircleAvatar(
            radius: 15,
            backgroundColor: c.surface,
            child: Icon(Icons.edit_rounded, size: 16, color: c.primary),
          ),
        ],
      ),
    );
  }
}
