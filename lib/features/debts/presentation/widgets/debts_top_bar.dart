import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/action_icons.dart';
import 'package:flux_wallet/features/debts/presentation/pages/open_new_debt.dart';
import 'package:flux_wallet/features/shell/presentation/widgets/main_top_bar.dart';

class DebtsTopBar extends StatelessWidget {
  const DebtsTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MainTopBar(
      title: 'Borclar',
      actions: [
        IconButton(
          tooltip: 'Yeni borc',
          icon: Icon(ActionIcons.addCircle),
          onPressed: () => openNewDebt(context),
        ),
      ],
    );
  }
}
