import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_confirm.dart';

/// Importing replaces everything, so it is confirmed first.
Future<bool> confirmImport(BuildContext context) => confirmDialog(
  context,
  title: 'Məlumatları idxal et',
  message: 'Bütün cari məlumatlar seçilən fayldakı məlumatlarla əvəz olunacaq.',
  confirmLabel: 'İdxal et',
  destructive: true,
);
