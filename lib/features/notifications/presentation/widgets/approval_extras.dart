import 'package:flutter/material.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_cubit.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_item.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/bus_replace_prompt.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/remember_row.dart';

/// The conditional parts of a card: the bus question and "remember merchant".
class ApprovalExtras extends StatelessWidget {
  const ApprovalExtras({super.key, required this.item, required this.cubit});

  final ApprovalItem item;
  final ApprovalCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        if (item.asksAboutBus)
          BusReplacePrompt(
            answer: item.replaceBus,
            onAnswer: (v) => cubit.setReplaceBus(item.id, v),
          ),
        if (item.category != null)
          RememberRow(
            category: item.category!,
            value: item.remember,
            onChanged: (v) => cubit.setRemember(item.id, v),
          ),
      ],
    );
  }
}
