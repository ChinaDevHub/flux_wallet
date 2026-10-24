import 'package:flutter/material.dart';

/// The avatar's flight between the profile and the full-screen viewer.
class AvatarHero extends StatelessWidget {
  const AvatarHero({super.key, required this.child});

  static const tag = 'profile-avatar';

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      Hero(tag: tag, transitionOnUserGestures: true, child: child);
}
