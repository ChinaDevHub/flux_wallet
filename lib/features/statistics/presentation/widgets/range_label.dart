import 'package:flux_wallet/core/utils/az_names.dart';
import 'package:flux_wallet/features/statistics/domain/entities/stats_range.dart';

/// "Okt 2026", "May – Okt 2026", "Dek 2025 – Mar 2026".
String rangeLabel(StatsRange r) {
  String short(DateTime m) => azMonthsShort[m.month - 1];
  if (r.from == r.to) return '${short(r.from)} ${r.from.year}';
  if (r.from.year == r.to.year) {
    return '${short(r.from)} – ${short(r.to)} ${r.to.year}';
  }
  return '${short(r.from)} ${r.from.year} – ${short(r.to)} ${r.to.year}';
}

/// "Okt 2026": one month as the slider's knobs name it.
String monthLabel(DateTime m) => '${azMonthsShort[m.month - 1]} ${m.year}';
