import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/platform/adaptive_loader.dart';
import 'package:flux_wallet/features/home/presentation/cubit/home_cubit.dart';
import 'package:flux_wallet/features/home/presentation/cubit/home_state.dart';
import 'package:flux_wallet/features/home/presentation/widgets/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return SafeArea(
      bottom: false,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: switch (state) {
            HomeLoaded(:final snapshot) => HomeBody(
              key: const ValueKey('loaded'),
              snapshot: snapshot,
              onRefresh: cubit.load,
            ),
            HomeFailure() => Center(
              child: TextButton(
                onPressed: cubit.load,
                child: const Text('Xəta baş verdi. Yenidən cəhd et'),
              ),
            ),
            HomeLoading() => const Center(child: AdaptiveLoader()),
          },
        ),
      ),
    );
  }
}
