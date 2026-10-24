import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';
import 'package:flux_wallet/core/platform/range_slider_themes.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// A two-knob slider over [steps] stops, styled the way each platform's own
/// sliders look. [onChangeEnd] fires once, when the finger lifts.
class AdaptiveRangeSlider extends StatelessWidget {
  const AdaptiveRangeSlider({
    super.key,
    required this.values,
    required this.steps,
    required this.labels,
    required this.onChanged,
    required this.onChangeEnd,
  });

  final RangeValues values;
  final int steps;
  final RangeLabels labels;
  final ValueChanged<RangeValues> onChanged, onChangeEnd;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SliderTheme(
      data: context.isCupertino
          ? cupertinoRangeTheme(c)
          : materialRangeTheme(c),
      child: RangeSlider(
        values: values,
        max: (steps - 1).toDouble(),
        divisions: steps > 1 ? steps - 1 : null,
        labels: labels,
        onChanged: onChanged,
        onChangeEnd: onChangeEnd,
      ),
    );
  }
}
