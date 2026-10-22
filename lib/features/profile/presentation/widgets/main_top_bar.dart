import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/app_top_bar.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/profile_avatar_button.dart';

/// The top bar of the main tabs, with the user's avatar on the right.
class MainTopBar extends StatelessWidget {
  const MainTopBar({super.key, required this.title, this.actions = const []});

  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => AppTopBar(
    title: title,
    actions: actions,
    avatar: const ProfileAvatarButton(),
  );
}
