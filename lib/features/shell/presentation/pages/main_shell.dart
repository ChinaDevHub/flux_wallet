import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/home/presentation/pages/home_page.dart';
import 'package:flux_wallet/features/shell/presentation/widgets/coming_soon.dart';
import 'package:flux_wallet/features/shell/presentation/widgets/shell_bottom_bar.dart';
import 'package:flux_wallet/features/timeline/presentation/pages/timeline_page.dart';
import 'package:flux_wallet/features/transactions/presentation/pages/open_new_transaction.dart';

/// Tabs (kept alive) + the docked "+" that opens the new-transaction screen.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNewTransaction(context),
        backgroundColor: c.text,
        foregroundColor: c.background,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, size: 30),
      ),
      bottomNavigationBar: ShellBottomBar(
        currentIndex: _index,
        onSelected: (i) => setState(() => _index = i),
      ),
      body: IndexedStack(
        index: _index,
        children: const [
          HomePage(),
          TimelinePage(),
          ComingSoon('Borclar'),
          ComingSoon('Statistika'),
        ],
      ),
    );
  }
}
