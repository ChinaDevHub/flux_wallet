import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

InputDecoration appInputDecoration(
  AppColors c, {
  required String label,
  String? hint,
  String? suffix,
}) {
  OutlineInputBorder border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: color, width: width),
      );
  return InputDecoration(
    labelText: label,
    hintText: hint,
    suffixText: suffix,
    filled: true,
    fillColor: c.surface,
    border: border(c.divider),
    enabledBorder: border(c.divider),
    focusedBorder: border(c.primary, 1.6),
  );
}

List<TextInputFormatter> numericFormatters({required bool integersOnly}) => [
  if (integersOnly)
    FilteringTextInputFormatter.digitsOnly
  else
    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
];
