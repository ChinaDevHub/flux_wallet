import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/platform/adaptive_loader.dart';
import 'package:flux_wallet/core/platform/adaptive_refresh.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/debts_state.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debts_body.dart';

/// The "Borclar" tab.
class DebtsPage extends StatelessWidget {
  const DebtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DebtsCubit>();
    return SafeArea(
      bottom: false,
      child: BlocBuilder<DebtsCubit, DebtsState>(
        builder: (context, state) => switch (state) {
          DebtsLoading() => const Center(child: AdaptiveLoader()),
          DebtsFailure() => Center(
            child: TextButton(
              onPressed: cubit.load,
              child: const Text('Xəta baş verdi. Yenidən cəhd et'),
            ),
          ),
          DebtsLoaded() => AdaptiveRefresh(
            onRefresh: cubit.load,
            child: DebtsBody(state: state, cubit: cubit),
          ),
        },
      ),
    );
  }
}
