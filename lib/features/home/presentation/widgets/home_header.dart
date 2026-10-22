import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/az_calendar.dart';
import 'package:flux_wallet/features/home/presentation/widgets/home_settings_button.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.name, required this.now});

  final String name;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${azGreeting(now.hour)}, $name',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: c.text,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                azFullDate(now),
                style: TextStyle(fontSize: 13, color: c.textMuted),
              ),
            ],
          ),
        ),
        const HomeSettingsButton(),
      ],
    );
  }
}
