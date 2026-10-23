import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/icons/arrow_icons.dart';
import 'package:flux_wallet/core/icons/status_icons.dart';
import 'package:flux_wallet/core/platform/adaptive_sheet.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/budget/presentation/cubit/daily_cap_cubit.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/budget_texts.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/daily_cap_sheet.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_row.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_section.dart';

/// "Gündəlik xərc limiti": the user's own ceiling per day.
class BudgetSection extends StatelessWidget {
  const BudgetSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DailyCapCubit>();
    return BlocBuilder<DailyCapCubit, double?>(
      builder: (context, cap) => SettingsSection(
        title: 'Büdcə',
        footer: budgetFooter,
        children: [
          SettingsRow(
            icon: StatusIcons.warning,
            title: 'Gündəlik xərc limiti',
            subtitle: cap == null
                ? 'Təyin edilməyib'
                : '${formatAzn(cap)} / gün',
            trailing: Icon(ArrowIcons.next),
            onTap: () => showAppSheet<void>(
              context,
              (_) => DailyCapSheet(
                current: cap,
                onSave: cubit.save,
                onClear: cubit.clear,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
