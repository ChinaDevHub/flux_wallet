import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_confirm.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';

/// Native "are you sure": deleting a debt undoes its effect on the balance.
Future<bool> confirmDeleteDebt(BuildContext context, DebtSummary summary) =>
    confirmDialog(
      context,
      title: 'Borcu sil',
      message:
          '${summary.debt.person} borcu silinəcək və onunla bağlı bütün '
          'pul hərəkətləri (verilən/alınan və ödənişlər) balansdan geri '
          'qaytarılacaq.',
      confirmLabel: 'Sil',
      destructive: true,
    );
