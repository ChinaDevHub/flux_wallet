import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_cubit.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_item.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/approval_actions.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/approval_category_chips.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/approval_extras.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/approval_merchant_row.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/approval_raw_line.dart';

class ApprovalCard extends StatelessWidget {
  const ApprovalCard({super.key, required this.item, required this.cubit});

  final ApprovalItem item;
  final ApprovalCubit cubit;

  @override
  Widget build(BuildContext context) {
    final p = item.view.pending;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          ApprovalRawLine(p.rawText),
          ApprovalMerchantRow(pending: p, category: item.category),
          ApprovalCategoryChips(
            type: p.type,
            selected: item.category,
            onSelected: (c) => cubit.setCategory(item.id, c),
          ),
          ApprovalExtras(item: item, cubit: cubit),
          ApprovalActions(
            canConfirm: item.canConfirm,
            onConfirm: () => cubit.confirm(item),
            onDismiss: () => cubit.dismiss(item),
          ),
        ],
      ),
    );
  }
}
