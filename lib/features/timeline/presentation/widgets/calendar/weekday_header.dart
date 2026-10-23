import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// B.e Ç.a Çər C.a Cüm Şən Baz over the grid.
class WeekdayHeader extends StatelessWidget {
  const WeekdayHeader({super.key});

  static const _labels = ['B.e', 'Ç.a', 'Çər', 'C.a', 'Cüm', 'Şən', 'Baz'];

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      color: context.colors.textMuted,
    );
    return Row(
      children: [
        for (final l in _labels)
          Expanded(
            child: Center(child: Text(l, style: style)),
          ),
      ],
    );
  }
}
