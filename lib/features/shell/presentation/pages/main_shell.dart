import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/icons/action_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/widgets/lazy_indexed_stack.dart';
import 'package:flux_wallet/features/debts/presentation/pages/debts_page.dart';
import 'package:flux_wallet/features/home/presentation/pages/home_page.dart';
import 'package:flux_wallet/features/shell/presentation/cubit/shell_tab_cubit.dart';
import 'package:flux_wallet/features/shell/presentation/widgets/shell_bottom_bar.dart';
import 'package:flux_wallet/features/statistics/presentation/pages/statistics_page.dart';
import 'package:flux_wallet/features/timeline/presentation/pages/timeline_page.dart';
import 'package:flux_wallet/features/transactions/presentation/pages/open_new_transaction.dart';

/// Tabs (kept alive) + the docked "+" that opens the new-transaction screen.
class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final tabs = context.read<ShellTabCubit>();
    return BlocBuilder<ShellTabCubit, int>(
      builder: (context, index) => Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () => openNewTransaction(context),
          backgroundColor: c.text,
          foregroundColor: c.background,
          shape: const CircleBorder(),
          child: Icon(ActionIcons.add, size: 30),
        ),
        bottomNavigationBar: ShellBottomBar(
          currentIndex: index,
          onSelected: tabs.select,
        ),
        body: LazyIndexedStack(
          index: index,
          children: const [
            HomePage(),
            TimelinePage(),
            DebtsPage(),
            StatisticsPage(),
          ],
        ),
      ),
    );
  }
}
