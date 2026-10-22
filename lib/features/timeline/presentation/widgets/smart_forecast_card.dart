import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/status_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_view.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/forecast_body.dart';

class SmartForecastCard extends StatelessWidget {
  const SmartForecastCard(this.view, {super.key});

  final TimelineView view;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final warning = (view.lowest?.endBalance ?? 0) < 0;
    final tint = warning ? c.accent : c.primary;
    final icon = warning ? StatusIcons.warning : StatusIcons.tip;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: tint,
            child: Icon(icon, size: 19, color: c.onPrimary),
          ),
          Expanded(child: ForecastBody(view)),
        ],
      ),
    );
  }
}
