import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/core/widgets/category_icon_box.dart';
import 'package:flux_wallet/features/notifications/domain/entities/pending_transaction.dart';

class ApprovalMerchantRow extends StatelessWidget {
  const ApprovalMerchantRow({super.key, required this.pending, this.category});

  final PendingTransaction pending;
  final String? category;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final amount = pending.type.name == 'income'
        ? pending.amount
        : -pending.amount;
    return Row(
      spacing: 12,
      children: [
        CategoryIconBox(category ?? 'other'),
        Expanded(
          child: Text(
            pending.merchant,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: c.text,
            ),
          ),
        ),
        Text(
          formatAzn(amount, signed: true),
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: amount > 0 ? c.positive : c.text,
          ),
        ),
      ],
    );
  }
}
