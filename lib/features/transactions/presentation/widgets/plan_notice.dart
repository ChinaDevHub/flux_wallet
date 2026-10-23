import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/info_box.dart';
import 'package:flux_wallet/core/widgets/reveal.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';

/// Shown for a later date: what saving it will do.
class PlanNotice extends StatelessWidget {
  const PlanNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTransactionCubit, NewTransactionState>(
      buildWhen: (a, b) => a.isPlan != b.isPlan,
      builder: (context, s) => Reveal(
        open: s.isPlan,
        child: const Padding(
          padding: EdgeInsets.only(top: 8),
          child: InfoBox(
            'Bu gün hələ gəlməyib, ona görə plan kimi əlavə olunur. Həmin gün '
            'təqvimdə görünəcək və gündəlik limitə təsir edəcək.',
          ),
        ),
      ),
    );
  }
}
