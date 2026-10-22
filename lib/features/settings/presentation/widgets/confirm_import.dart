import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_confirm.dart';

/// Restoring replaces everything, so it is confirmed first.
Future<bool> confirmImport(BuildContext context) => confirmDialog(
  context,
  title: 'Məlumatları bərpa et',
  message:
      'Hesabındakı cari məlumatlar seçilən fayldakı məlumatlarla əvəz olunacaq.',
  confirmLabel: 'Bərpa et',
  destructive: true,
);
