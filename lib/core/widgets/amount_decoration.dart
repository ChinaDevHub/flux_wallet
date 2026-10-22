import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

InputDecoration amountDecoration(AppColors c) => InputDecoration(
  hintText: '0.00',
  hintStyle: TextStyle(color: c.textMuted.withValues(alpha: 0.4)),
  border: InputBorder.none,
);

const amountKeyboard = TextInputType.numberWithOptions(decimal: true);

final amountFormatters = [
  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
];
