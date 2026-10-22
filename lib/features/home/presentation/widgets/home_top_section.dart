import 'package:flutter/material.dart';
import 'package:flux_wallet/features/shell/presentation/widgets/main_top_bar.dart';
import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';
import 'package:flux_wallet/features/home/presentation/widgets/home_header.dart';
import 'package:flux_wallet/features/home/presentation/widgets/limit_card.dart';
import 'package:flux_wallet/features/home/presentation/widgets/pending_banner.dart';
import 'package:flux_wallet/features/home/presentation/widgets/shortfall_banner.dart';

/// Everything above "Bu gün": bar, greeting, limit card and the banners.
class HomeTopSection extends StatelessWidget {
  const HomeTopSection(this.snapshot, {super.key});

  final HomeSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final s = snapshot;
    return Column(
      spacing: 12,
      children: [
        const MainTopBar(title: 'Əsas Ekran'),
        const SizedBox(height: 8),
        HomeHeader(name: s.userName, now: DateTime.now()),
        LimitCard(snapshot: s),
        if (s.pendingCount > 0) PendingBanner(count: s.pendingCount),
        if (s.limit.hasShortfall) ShortfallBanner(amount: s.limit.shortfall),
      ],
    );
  }
}
