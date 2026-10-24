import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/action_icons.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/profile/presentation/viewer/avatar_full.dart';
import 'package:flux_wallet/features/profile/presentation/viewer/avatar_hero.dart';
import 'package:flux_wallet/features/profile/presentation/viewer/zoomable_dismiss.dart';

/// The profile picture full screen on black: zoom in, swipe away, or tap
/// the pencil to change it.
class AvatarViewerPage extends StatelessWidget {
  const AvatarViewerPage({super.key, required this.user, required this.onEdit});

  final User user;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text(user.fullName),
        actions: [
          IconButton(
            tooltip: 'Dəyiş',
            icon: Icon(ActionIcons.edit),
            onPressed: () {
              Navigator.pop(context);
              onEdit();
            },
          ),
        ],
      ),
      body: ZoomableDismiss(
        child: AvatarHero(child: AvatarFull(user: user)),
      ),
    );
  }
}
