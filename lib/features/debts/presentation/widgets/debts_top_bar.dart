import 'package:flutter/material.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/main_top_bar.dart';
import 'package:flux_wallet/features/debts/presentation/pages/open_new_debt.dart';

class DebtsTopBar extends StatelessWidget {
  const DebtsTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MainTopBar(
      title: 'Borclar',
      actions: [
        IconButton(
          tooltip: 'Yeni borc',
          icon: const Icon(Icons.add_circle_outline_rounded),
          onPressed: () => openNewDebt(context),
        ),
      ],
    );
  }
}
