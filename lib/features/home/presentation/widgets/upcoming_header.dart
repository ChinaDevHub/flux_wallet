import 'package:flutter/material.dart';
import 'package:flux_wallet/features/home/presentation/widgets/section_title.dart';
import 'package:flux_wallet/features/rules/presentation/pages/open_rules_page.dart';

class UpcomingHeader extends StatelessWidget {
  const UpcomingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionTitle(
      'Qarşıda',
      subtitle: 'Növbəti zəruri ödənişlər',
      trailing: TextButton(
        onPressed: () => openRulesPage(context),
        child: const Text('Hamısı'),
      ),
    );
  }
}
