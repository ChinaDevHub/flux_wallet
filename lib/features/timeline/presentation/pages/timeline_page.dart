import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/platform/adaptive_loader.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_cubit.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_state.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/timeline_body.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TimelineCubit>();
    return SafeArea(
      bottom: false,
      child: BlocBuilder<TimelineCubit, TimelineState>(
        builder: (context, state) => switch (state) {
          TimelineLoading() => const Center(child: AdaptiveLoader()),
          TimelineFailure() => Center(
            child: TextButton(
              onPressed: cubit.load,
              child: const Text('Xəta baş verdi. Yenidən cəhd et'),
            ),
          ),
          TimelineLoaded() => TimelineBody(state: state, cubit: cubit),
        },
      ),
    );
  }
}
