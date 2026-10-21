import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/platform/adaptive_loader.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rules_cubit.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rules_state.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/rules_list.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RulesCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Təkrarlanan Qaydalar')),
      body: SafeArea(
        child: BlocBuilder<RulesCubit, RulesState>(
          builder: (context, state) => switch (state) {
            RulesLoading() => const Center(child: AdaptiveLoader()),
            RulesFailure() => Center(
              child: TextButton(
                onPressed: cubit.load,
                child: const Text('Xəta baş verdi. Yenidən cəhd et'),
              ),
            ),
            RulesLoaded() => RulesList(
              active: state.active,
              passive: state.passive,
              onToggle: (r, v) => cubit.toggle(r.id!, v),
              onRefresh: cubit.load,
            ),
          },
        ),
      ),
    );
  }
}
