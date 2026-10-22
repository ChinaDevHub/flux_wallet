import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/arrow_icons.dart';
import 'package:flux_wallet/core/icons/nav_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/home/presentation/widgets/pending_banner_text.dart';
import 'package:flux_wallet/features/notifications/presentation/pages/open_approval_page.dart';

/// "2 bank bildirişi təsdiq gözləyir" — opens the approval queue.
class PendingBanner extends StatelessWidget {
  const PendingBanner({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Material(
      color: c.accentSoft,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => openApprovalPage(context),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            spacing: 12,
            children: [
              Icon(NavIcons.bellActive, color: c.accent),
              Expanded(child: PendingBannerText(count)),
              Icon(ArrowIcons.forward, color: c.accent),
            ],
          ),
        ),
      ),
    );
  }
}
