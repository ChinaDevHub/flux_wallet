import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_view.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/forecast_text.dart';

class ForecastBody extends StatelessWidget {
  const ForecastBody(this.view, {super.key});

  final TimelineView view;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ağıllı Proqnoz',
          style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
        ),
        const SizedBox(height: 3),
        Text(
          forecastText(view),
          style: TextStyle(fontSize: 13, height: 1.4, color: c.text),
        ),
      ],
    );
  }
}
