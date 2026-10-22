import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_refresh.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_cubit.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_item.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/approval_card.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/empty_approval.dart';

class ApprovalList extends StatelessWidget {
  const ApprovalList({super.key, required this.items, required this.cubit});

  final List<ApprovalItem> items;
  final ApprovalCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AdaptiveRefresh(
      onRefresh: cubit.load,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          if (items.isEmpty) const EmptyApproval(),
          for (final item in items)
            ApprovalCard(key: ValueKey(item.id), item: item, cubit: cubit),
        ],
      ),
    );
  }
}
