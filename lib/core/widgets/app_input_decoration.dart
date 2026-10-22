import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

TextStyle appInputStyle(BuildContext context) => TextStyle(
  color: context.colors.text,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

InputDecoration appInputDecoration(
  BuildContext context, {
  required String label,
  String? hint,
  String? suffix,
  String? errorText,
  Widget? suffixIcon,
}) {
  final c = context.colors;
  OutlineInputBorder border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: color, width: width),
      );
  return InputDecoration(
    labelText: label,
    hintText: hint,
    hintStyle: TextStyle(color: c.textMuted),
    suffixText: suffix,
    suffixIcon: suffixIcon,
    errorText: errorText,
    filled: true,
    fillColor: c.surface,
    border: border(c.divider),
    enabledBorder: border(c.divider),
    focusedBorder: border(c.primary, 1.6),
    errorBorder: border(c.negative),
    focusedErrorBorder: border(c.negative, 1.6),
  );
}

List<TextInputFormatter> numericFormatters({required bool integersOnly}) => [
  if (integersOnly)
    FilteringTextInputFormatter.digitsOnly
  else
    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
];
