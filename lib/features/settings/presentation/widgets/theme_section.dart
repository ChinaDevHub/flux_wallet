import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/platform/adaptive_segmented.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/theme_cubit.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_section.dart';

/// İşıqlı / Qaranlıq / Sistem.
class ThemeSection extends StatelessWidget {
  const ThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Görünüş',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) => SizedBox(
              width: double.infinity,
              child: AdaptiveSegmented<ThemeMode>(
                selected: mode,
                onChanged: context.read<ThemeCubit>().select,
                options: const {
                  ThemeMode.light: 'İşıqlı',
                  ThemeMode.dark: 'Qaranlıq',
                  ThemeMode.system: 'Sistem',
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
