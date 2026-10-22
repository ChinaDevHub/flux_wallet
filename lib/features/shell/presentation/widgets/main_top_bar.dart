import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/app_top_bar.dart';
import 'package:flux_wallet/features/notices/presentation/widgets/notice_bell_button.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/profile_avatar_button.dart';

/// The top bar of the main tabs: the notification bell and the user's avatar
/// sit on the right, after any screen-specific [actions].
class MainTopBar extends StatelessWidget {
  const MainTopBar({super.key, required this.title, this.actions = const []});

  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => AppTopBar(
    title: title,
    actions: [
      ...actions,
      const NoticeBellButton(),
      const ProfileAvatarButton(),
    ],
  );
}
