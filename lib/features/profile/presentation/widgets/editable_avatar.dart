import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/action_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/profile/presentation/viewer/avatar_hero.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/user_avatar.dart';

/// The big avatar: tap it to look at it full screen, tap the pencil badge
/// to change it.
class EditableAvatar extends StatelessWidget {
  const EditableAvatar({
    super.key,
    required this.user,
    required this.onView,
    required this.onEdit,
  });

  final User user;
  final VoidCallback onView, onEdit;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onTap: onView,
          child: AvatarHero(
            child: UserAvatar(
              avatarUrl: user.avatarUrl,
              fullName: user.fullName,
              radius: 48,
            ),
          ),
        ),
        GestureDetector(
          onTap: onEdit,
          child: CircleAvatar(
            radius: 15,
            backgroundColor: c.surface,
            child: Icon(ActionIcons.edit, size: 16, color: c.primary),
          ),
        ),
      ],
    );
  }
}
