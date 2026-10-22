import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/widgets/category_style.dart';

/// "Bu satıcını həmişə Ərzaq kimi yaz".
class RememberRow extends StatelessWidget {
  const RememberRow({
    super.key,
    required this.category,
    required this.value,
    required this.onChanged,
  });

  final String category;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      children: [
        Checkbox.adaptive(
          value: value,
          activeColor: c.primary,
          onChanged: (v) => onChanged(v ?? false),
        ),
        Expanded(
          child: Text(
            'Bu satıcını həmişə ${CategoryStyle.of(category).label} kimi yaz',
            style: TextStyle(fontSize: 13, color: c.text),
          ),
        ),
      ],
    );
  }
}
