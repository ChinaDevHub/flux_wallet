import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/security_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/security/presentation/widgets/ring_avatar.dart';

/// The signed-in user's avatar and a small "locked" mark.
class LockHeader extends StatelessWidget {
  const LockHeader({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        spacing: 16,
        children: [
          RingAvatar(user: user),
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              Icon(SecurityIcons.lockFilled, size: 14, color: c.textMuted),
              Text(
                'Flux Wallet kilidlidir',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                  color: c.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
