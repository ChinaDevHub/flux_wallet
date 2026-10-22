import 'package:flutter/material.dart';
import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/features/settings/domain/entities/setting_keys.dart';
import 'package:flux_wallet/features/settings/domain/repositories/settings_repository.dart';

/// Light / dark / system, remembered across launches and restored by imports.
class ThemeCubit extends ReloadingCubit<ThemeMode> {
  ThemeCubit(
    this._settings,
    Stream<void> changes, {
    ThemeMode initial = ThemeMode.system,
  }) : super(initial, changes);

  final SettingsRepository _settings;

  @override
  Future<void> load() async {
    final saved = await _settings.read(SettingKeys.themeMode);
    emit(ThemeMode.values.asNameMap()[saved] ?? ThemeMode.system);
  }

  Future<void> select(ThemeMode mode) async {
    emit(mode);
    await _settings.write(SettingKeys.themeMode, mode.name);
  }
}
