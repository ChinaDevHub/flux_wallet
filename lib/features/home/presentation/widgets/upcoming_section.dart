import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';
import 'package:flux_wallet/features/home/presentation/widgets/upcoming_header.dart';
import 'package:flux_wallet/features/home/presentation/widgets/upcoming_card.dart';

class UpcomingSection extends StatelessWidget {
  const UpcomingSection({super.key, required this.snapshot});

  final HomeSnapshot snapshot;

  static const _gutter = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final items = snapshot.upcoming;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: _gutter, child: UpcomingHeader()),
        const SizedBox(height: 12),
        if (items.isEmpty)
          Padding(
            padding: _gutter,
            child: Text(
              'Yaxın 14 gündə ödəniş yoxdur',
              style: TextStyle(color: c.textMuted),
            ),
          )
        else
          SizedBox(
            height: 132,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: _gutter,
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (_, i) =>
                  UpcomingCard(payment: items[i], today: snapshot.today),
            ),
          ),
      ],
    );
  }
}
