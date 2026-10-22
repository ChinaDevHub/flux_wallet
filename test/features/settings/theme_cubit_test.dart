import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/settings/domain/entities/setting_keys.dart';
import 'package:flux_wallet/features/settings/domain/repositories/settings_repository.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/theme_cubit.dart';

class _Settings implements SettingsRepository {
  final values = <String, String>{};
  @override
  Future<String?> read(String key) async => values[key];
  @override
  Future<void> write(String key, String value) async => values[key] = value;
}

void main() {
  test('defaults to the system theme and remembers the choice', () async {
    final settings = _Settings();
    final changes = StreamController<void>.broadcast();
    final cubit = ThemeCubit(settings, changes.stream);
    await cubit.load();
    expect(cubit.state, ThemeMode.system);
    await cubit.select(ThemeMode.dark);
    expect(settings.values[SettingKeys.themeMode], 'dark');
    expect(cubit.state, ThemeMode.dark);
    await cubit.close();
    await changes.close();
  });

  test('a restored backup (database change) updates the theme', () async {
    final settings = _Settings();
    final changes = StreamController<void>.broadcast();
    final cubit = ThemeCubit(settings, changes.stream);
    settings.values[SettingKeys.themeMode] = 'light';
    changes.add(null);
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state, ThemeMode.light);
    await cubit.close();
    await changes.close();
  });

  test('an unknown stored value falls back to system', () async {
    final settings = _Settings()..values[SettingKeys.themeMode] = 'neon';
    final changes = StreamController<void>.broadcast();
    final cubit = ThemeCubit(settings, changes.stream);
    await cubit.load();
    expect(cubit.state, ThemeMode.system);
    await cubit.close();
    await changes.close();
  });
}
