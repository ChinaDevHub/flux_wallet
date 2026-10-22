import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/platform/adaptive_loader.dart';
import 'package:flux_wallet/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:flux_wallet/features/statistics/presentation/cubit/statistics_state.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/statistics_body.dart';

/// The "Statistika" tab.
class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StatisticsCubit>();
    return SafeArea(
      bottom: false,
      child: BlocBuilder<StatisticsCubit, StatisticsState>(
        builder: (context, state) => switch (state) {
          StatisticsLoading() => const Center(child: AdaptiveLoader()),
          StatisticsFailure() => Center(
            child: TextButton(
              onPressed: cubit.load,
              child: const Text('Xəta baş verdi. Yenidən cəhd et'),
            ),
          ),
          StatisticsLoaded(:final view) => StatisticsBody(
            view: view,
            cubit: cubit,
          ),
        },
      ),
    );
  }
}
