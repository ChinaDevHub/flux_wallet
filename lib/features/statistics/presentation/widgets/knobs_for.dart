import 'package:flutter/material.dart';
import 'package:flux_wallet/features/statistics/domain/entities/stats_range.dart';

/// Where the slider's knobs sit for [range] among [months].
RangeValues knobsFor(List<DateTime> months, StatsRange range) {
  double at(DateTime m) => months.indexOf(m).clamp(0, months.length - 1) * 1.0;
  return RangeValues(at(range.from), at(range.to));
}
