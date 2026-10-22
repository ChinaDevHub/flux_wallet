import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/app_input_decoration.dart';
import 'package:flux_wallet/core/widgets/field_kind.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.onChanged,
    this.kind = FieldKind.text,
    this.controller,
    this.hint,
    this.suffix,
    this.errorText,
    this.trailing,
    this.action,
    this.onSubmitted,
  });

  final String label;
  final FieldKind kind;
  final String? hint, suffix, errorText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final Widget? trailing; // e.g. the "show password" eye
  final TextInputAction? action;

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    onChanged: onChanged,
    onSubmitted: onSubmitted,
    obscureText: kind.isSecret,
    autocorrect: kind.autocorrects,
    textInputAction: action,
    textCapitalization: kind.capitalization,
    keyboardType: kind.keyboard,
    inputFormatters: kind.formatters,
    style: appInputStyle(context),
    decoration: appInputDecoration(
      context,
      label: label,
      hint: hint,
      suffix: suffix,
      errorText: errorText,
      suffixIcon: trailing,
    ),
  );
}
