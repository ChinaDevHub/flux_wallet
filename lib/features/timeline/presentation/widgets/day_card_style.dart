import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';

/// Expenses from this amount on tint the card as a "heavy" day.
const heavyExpense = 50.0;

String dayCaption(TimelineDay day, {required bool isLowest}) {
  if (day.hasIncome) return 'Yeni balans';
  if (isLowest && day.hasExpense) return 'Aşağı balans';
  return day.isPast ? 'Balans' : 'Proqnoz';
}

Color dayTint(AppColors c, TimelineDay day) {
  if (day.hasIncome) return c.primary.withValues(alpha: 0.12);
  final heavy = day.entries.any((e) => e.signedAmount <= -heavyExpense);
  return heavy ? c.accentSoft : c.surface;
}
