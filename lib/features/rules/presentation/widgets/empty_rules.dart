import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

class EmptyRules extends StatelessWidget {
  const EmptyRules({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Center(
        child: Text(
          'Hələ təkrarlanan qayda yoxdur',
          style: TextStyle(color: context.colors.textMuted),
        ),
      ),
    );
  }
}
