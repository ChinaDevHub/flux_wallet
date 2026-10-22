import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_confirm.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';

/// Native "are you sure" before a debt and its payment history are removed.
Future<bool> confirmDeleteDebt(BuildContext context, DebtSummary summary) =>
    confirmDialog(
      context,
      title: 'Borcu sil',
      message:
          '${summary.debt.person} borcu və ödəniş tarixçəsi silinəcək. '
          'Balans dəyişmir.',
      confirmLabel: 'Sil',
      destructive: true,
    );
