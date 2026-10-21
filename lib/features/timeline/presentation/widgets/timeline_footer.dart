import 'package:flutter/material.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_view.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/smart_forecast_card.dart';

/// Sliver with the forecast card; the bottom gap clears the tab bar.
class TimelineFooter extends StatelessWidget {
  const TimelineFooter(this.view, {super.key});

  final TimelineView view;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 6, bottom: 140),
      sliver: SliverToBoxAdapter(child: SmartForecastCard(view)),
    );
  }
}
