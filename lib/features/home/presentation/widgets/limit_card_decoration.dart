import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

BoxDecoration limitCardDecoration(AppColors c) => BoxDecoration(
  borderRadius: BorderRadius.circular(28),
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [c.primaryLight, c.primary],
  ),
);
