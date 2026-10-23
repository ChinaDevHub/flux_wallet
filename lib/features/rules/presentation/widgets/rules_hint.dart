import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// How to manage a rule, and what switching it off or deleting it does.
class RulesHint extends StatelessWidget {
  const RulesHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
      child: Text(
        'Söndür və ya sil: bu gündən etibarən planlanmır, keçmiş günlər və '
        'onların limiti olduğu kimi qalır. Redaktə və silmək üçün sətri sola '
        'sürüşdür və ya uzun bas.',
        style: TextStyle(
          fontSize: 12.5,
          height: 1.4,
          color: context.colors.textMuted,
        ),
      ),
    );
  }
}
