import 'package:flutter/material.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/settings_result.dart';

const _messages = {
  SettingsResult.done: 'Hazırdır',
  SettingsResult.denied: 'Bildiriş icazəsi verilmədi. Sistem ayarlarından aç.',
  SettingsResult.invalid: 'Bu fayl Flux Wallet ehtiyat nüsxəsi deyil.',
  SettingsResult.failed: 'Əməliyyat alınmadı. Yenidən cəhd et.',
};

void showSettingsResult(BuildContext context, SettingsResult result) {
  final text = _messages[result];
  if (text == null) return;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
