import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/widgets/top_bar_title.dart';

/// "Büdcə / <title>" bar with the logo on the left and avatar on the right.
class AppTopBar extends StatelessWidget {
  const AppTopBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.avatar,
  });

  final String title;
  final List<Widget> actions;
  final Widget? avatar; // the account button; a person icon when null

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    Widget circle(IconData icon) => CircleAvatar(
      radius: 18,
      backgroundColor: c.primary,
      child: Icon(icon, size: 19, color: c.onPrimary),
    );
    return Row(
      children: [
        circle(Icons.account_balance_wallet_rounded),
        const SizedBox(width: 10),
        Expanded(child: TopBarTitle(title)),
        ...actions,
        Icon(Icons.notifications_none_rounded, color: c.text),
        const SizedBox(width: 14),
        avatar ?? circle(Icons.person_outline_rounded),
      ],
    );
  }
}
