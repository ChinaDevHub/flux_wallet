import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_state.dart';

/// Says in plain words what saving will do to the balance.
class DebtEffectNote extends StatelessWidget {
  const DebtEffectNote({super.key});

  String? _text(NewDebtState s) {
    final account = s.account;
    if (s.amount <= 0 || account == null) return null;
    final money = formatAzn(s.amount);
    return s.needsDueDate
        ? '${account.name} hesabına +$money əlavə olunacaq. Son tarixdə '
              'bu məbləğ məcburi xərc kimi görünəcək.'
        : '${account.name} hesabından $money çıxılacaq. Geri qayıdanda '
              '"Qaytarıldı" ilə gəlir kimi yazılacaq.';
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocBuilder<NewDebtCubit, NewDebtState>(
      builder: (context, s) {
        final text = _text(s);
        if (text == null) return const SizedBox.shrink();
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: c.surfaceAlt,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(text, style: TextStyle(fontSize: 13, color: c.textMuted)),
        );
      },
    );
  }
}
