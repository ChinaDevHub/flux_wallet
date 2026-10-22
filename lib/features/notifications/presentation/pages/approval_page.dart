import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/platform/adaptive_loader.dart';
import 'package:flux_wallet/core/platform/adaptive_sheet.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_cubit.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_state.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/approval_list.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/paste_message_sheet.dart';

/// The queue: nothing is booked until the user taps "Təsdiqlə".
class ApprovalPage extends StatelessWidget {
  const ApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ApprovalCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank bildirişləri'),
        actions: [
          IconButton(
            tooltip: 'Bank mətni əlavə et',
            icon: const Icon(Icons.edit_note_rounded),
            onPressed: () => showAppSheet<void>(
              context,
              (_) => PasteMessageSheet(onSubmit: cubit.addText),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ApprovalCubit, ApprovalState>(
          builder: (context, state) => switch (state) {
            ApprovalLoading() => const Center(child: AdaptiveLoader()),
            ApprovalFailure() => Center(
              child: TextButton(
                onPressed: cubit.load,
                child: const Text('Xəta baş verdi. Yenidən cəhd et'),
              ),
            ),
            ApprovalLoaded(:final items) => ApprovalList(
              items: items,
              cubit: cubit,
            ),
          },
        ),
      ),
    );
  }
}
