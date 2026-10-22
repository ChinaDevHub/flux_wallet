import 'package:flutter/material.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/debts_state.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_direction_selector.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_tile.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debts_list.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debts_top_bar.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debts_totals.dart';

class DebtsBody extends StatelessWidget {
  const DebtsBody({super.key, required this.state, required this.cubit});

  final DebtsLoaded state;
  final DebtsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final overview = state.overview;
    final today = DateTime.now();
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 140),
      children: [
        const DebtsTopBar(),
        const SizedBox(height: 16),
        DebtsTotals(overview),
        const SizedBox(height: 16),
        DebtDirectionSelector(
          selected: state.direction,
          onChanged: cubit.select,
        ),
        const SizedBox(height: 16),
        DebtsList(
          open: overview.open(state.direction),
          closed: overview.closed(state.direction),
          card: (s) => DebtTile(
            summary: s,
            accounts: state.accounts,
            cubit: cubit,
            today: today,
          ),
        ),
      ],
    );
  }
}
