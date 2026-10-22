import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/action_icons.dart';
import 'package:flux_wallet/core/platform/adaptive_sheet.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_cubit.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/paste_message_sheet.dart';

/// App-bar action: paste a bank message by hand.
class PasteMessageButton extends StatelessWidget {
  const PasteMessageButton({super.key, required this.cubit});

  final ApprovalCubit cubit;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Bank mətni əlavə et',
      icon: Icon(ActionIcons.editNote),
      onPressed: () => showAppSheet<void>(
        context,
        (_) => PasteMessageSheet(onSubmit: cubit.addText),
      ),
    );
  }
}
