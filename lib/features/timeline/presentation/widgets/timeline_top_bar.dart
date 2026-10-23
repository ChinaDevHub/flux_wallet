import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/action_icons.dart';
import 'package:flux_wallet/features/shell/presentation/widgets/main_top_bar.dart';
import 'package:flux_wallet/features/rules/presentation/pages/open_rules_page.dart';

/// Shared top bar + a shortcut to the recurring rules screen.
class TimelineTopBar extends StatelessWidget {
  const TimelineTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MainTopBar(
      title: 'Təqvim',
      actions: [
        IconButton(
          tooltip: 'Qaydalar',
          icon: Icon(ActionIcons.repeat),
          onPressed: () => openRulesPage(context),
        ),
      ],
    );
  }
}
