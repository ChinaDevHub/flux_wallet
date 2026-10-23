import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/user_avatar.dart';

/// The user's avatar inside a soft brand-coloured ring.
class RingAvatar extends StatelessWidget {
  const RingAvatar({super.key, required this.user, this.radius = 36});

  final User? user;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: context.colors.primary.withValues(alpha: 0.35),
        ),
      ),
      child: UserAvatar(
        avatarUrl: user?.avatarUrl,
        fullName: user?.fullName ?? '',
        radius: radius,
      ),
    );
  }
}
