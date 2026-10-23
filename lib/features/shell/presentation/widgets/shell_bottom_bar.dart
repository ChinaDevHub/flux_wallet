import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/nav_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/shell/presentation/widgets/shell_bar_item.dart';

/// Four tabs around the docked "+" button (index 2 and 3 sit on the right).
class ShellBottomBar extends StatelessWidget {
  const ShellBottomBar({
    super.key,
    required this.currentIndex,
    required this.onSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onSelected;

  static final _items = [
    (NavIcons.home, 'Əsas'),
    (NavIcons.timeline, 'Təqvim'),
    (NavIcons.debts, 'Borclar'),
    (NavIcons.stats, 'Statistika'),
  ];

  Widget _item(int i) => ShellBarItem(
    icon: _items[i].$1,
    label: _items[i].$2,
    selected: i == currentIndex,
    onTap: () => onSelected(i),
  );

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: context.colors.surface,
      elevation: 8,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        children: [_item(0), _item(1), const Spacer(), _item(2), _item(3)],
      ),
    );
  }
}
