import 'package:flutter/material.dart';
import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';
import 'package:flux_wallet/features/home/presentation/widgets/home_app_bar.dart';
import 'package:flux_wallet/features/home/presentation/widgets/home_header.dart';
import 'package:flux_wallet/features/home/presentation/widgets/limit_card.dart';
import 'package:flux_wallet/features/home/presentation/widgets/shortfall_banner.dart';
import 'package:flux_wallet/features/home/presentation/widgets/tip_card.dart';
import 'package:flux_wallet/features/home/presentation/widgets/today_section.dart';
import 'package:flux_wallet/features/home/presentation/widgets/upcoming_section.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key, required this.snapshot, required this.onRefresh});

  final HomeSnapshot snapshot;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final s = snapshot;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 140),
        children: [
          _pad(const HomeAppBar()),
          const SizedBox(height: 20),
          _pad(HomeHeader(name: s.userName, now: DateTime.now())),
          const SizedBox(height: 16),
          _pad(LimitCard(snapshot: s)),
          if (s.limit.hasShortfall) ...[
            const SizedBox(height: 12),
            _pad(ShortfallBanner(amount: s.limit.shortfall)),
          ],
          const SizedBox(height: 24),
          _pad(TodaySection(snapshot: s)),
          const SizedBox(height: 24),
          UpcomingSection(snapshot: s),
          const SizedBox(height: 24),
          _pad(TipCard(tip: s.tip)),
        ],
      ),
    );
  }

  static Widget _pad(Widget child) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: child,
  );
}
