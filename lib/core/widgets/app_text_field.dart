import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/widgets/app_input_decoration.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.onChanged,
    this.hint,
    this.suffix,
    this.numeric = false,
    this.integersOnly = false,
    this.capitalize = false,
  });

  final String label;
  final String? hint, suffix;
  final bool numeric, integersOnly, capitalize;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return TextField(
      onChanged: onChanged,
      textCapitalization: capitalize
          ? TextCapitalization.words
          : TextCapitalization.none,
      keyboardType: numeric
          ? TextInputType.numberWithOptions(decimal: !integersOnly)
          : TextInputType.text,
      inputFormatters: numeric
          ? numericFormatters(integersOnly: integersOnly)
          : null,
      style: TextStyle(
        color: c.text,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      decoration: appInputDecoration(
        c,
        label: label,
        hint: hint,
        suffix: suffix,
      ),
    );
  }
}
