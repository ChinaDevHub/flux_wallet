import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/home/presentation/cubit/home_cubit.dart';
import 'package:flux_wallet/features/home/presentation/cubit/home_state.dart';
import 'package:flux_wallet/features/home/presentation/widgets/home_body.dart';
import 'package:flux_wallet/features/home/presentation/widgets/home_bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: c.text,
        foregroundColor: c.background,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, size: 30),
      ),
      bottomNavigationBar: const HomeBottomBar(),
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: switch (state) {
              HomeLoaded(:final snapshot) => HomeBody(
                key: const ValueKey('loaded'),
                snapshot: snapshot,
                onRefresh: context.read<HomeCubit>().load,
              ),
              HomeFailure() => Center(
                child: TextButton(
                  onPressed: context.read<HomeCubit>().load,
                  child: const Text('Xəta baş verdi. Yenidən cəhd et'),
                ),
              ),
              HomeLoading() => const Center(child: CircularProgressIndicator()),
            },
          ),
        ),
      ),
    );
  }
}
