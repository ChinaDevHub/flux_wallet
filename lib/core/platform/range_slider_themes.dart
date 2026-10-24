import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// iOS: a thick pill track with big white knobs and no pop-up labels.
SliderThemeData cupertinoRangeTheme(AppColors c) => SliderThemeData(
  trackHeight: 8,
  activeTrackColor: c.primary,
  inactiveTrackColor: c.surfaceAlt,
  thumbColor: Colors.white,
  overlayColor: Colors.transparent,
  rangeThumbShape: const RoundRangeSliderThumbShape(
    enabledThumbRadius: 13,
    elevation: 3,
    pressedElevation: 6,
  ),
  rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
  rangeTickMarkShape: const RoundRangeSliderTickMarkShape(tickMarkRadius: 0),
  showValueIndicator: ShowValueIndicator.never,
);

/// Android: Material 3, with the month shown above the knob while dragging.
SliderThemeData materialRangeTheme(AppColors c) => SliderThemeData(
  trackHeight: 4,
  activeTrackColor: c.primary,
  inactiveTrackColor: c.primary.withValues(alpha: 0.2),
  thumbColor: c.primary,
  activeTickMarkColor: c.onPrimary.withValues(alpha: 0.6),
  inactiveTickMarkColor: c.primary.withValues(alpha: 0.4),
  valueIndicatorColor: c.primary,
  showValueIndicator: ShowValueIndicator.onDrag,
);
