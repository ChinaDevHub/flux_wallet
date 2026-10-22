import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_segmented.dart';
import 'package:flux_wallet/core/widgets/form_row.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';

/// "Hesab" row: pick the account (Kart / Nağd) the money moves through.
class AccountRow extends StatelessWidget {
  const AccountRow({
    super.key,
    required this.accounts,
    required this.selectedId,
    required this.onChanged,
    this.subtitle = 'Ödəniş vasitəsi',
  });

  final List<Account> accounts;
  final int? selectedId;
  final ValueChanged<int> onChanged;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return FormRow(
      title: 'Hesab',
      subtitle: subtitle,
      trailing: selectedId == null
          ? const SizedBox.shrink()
          : AdaptiveSegmented<int>(
              selected: selectedId!,
              onChanged: onChanged,
              options: {for (final a in accounts) a.id!: a.name},
            ),
    );
  }
}
