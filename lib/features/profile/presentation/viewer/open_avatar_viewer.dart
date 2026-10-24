import 'package:flutter/material.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/profile/presentation/viewer/avatar_viewer_page.dart';

/// Fades the viewer in over the profile while the avatar flies up into it.
Future<void> openAvatarViewer(
  BuildContext context,
  User user, {
  required VoidCallback onEdit,
}) {
  return Navigator.of(context).push(
    PageRouteBuilder<void>(
      opaque: false,
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (_, _, _) => AvatarViewerPage(user: user, onEdit: onEdit),
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  );
}
