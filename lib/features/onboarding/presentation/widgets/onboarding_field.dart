import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/core/widgets/app_text_field.dart';
import 'package:flux_wallet/core/widgets/field_kind.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/onboarding_cubit.dart';

/// A text field bound to one field of the [OnboardingCubit] form.
class OnboardingField extends StatelessWidget {
  const OnboardingField(
    this.fieldKey,
    this.label, {
    super.key,
    this.hint,
    this.money = false,
    this.day = false,
  });

  final String fieldKey, label;
  final String? hint;
  final bool money, day;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: AppTextField(
        label: label,
        hint: hint,
        suffix: money ? azn : null,
        kind: day ? FieldKind.integer : FieldKind.decimal,
        onChanged: (v) => context.read<OnboardingCubit>().changed(fieldKey, v),
      ),
    );
  }
}
