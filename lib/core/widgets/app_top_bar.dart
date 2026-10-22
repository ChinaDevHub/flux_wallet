import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/app_logo.dart';
import 'package:flux_wallet/core/widgets/top_bar_title.dart';

/// "Büdcə / <title>" bar: the logo on the left, [actions] on the right.
class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key, required this.title, this.actions = const []});

  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        const AppLogo(size: 36),
        Expanded(child: TopBarTitle(title)),
        ...actions,
      ],
    );
  }
}
