import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// Sliding segmented control on iOS, SegmentedButton on Android.
class AdaptiveSegmented<T extends Object> extends StatelessWidget {
  const AdaptiveSegmented({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final Map<T, String> options;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    if (context.isCupertino) {
      return CupertinoSlidingSegmentedControl<T>(
        groupValue: selected,
        backgroundColor: c.surfaceAlt,
        thumbColor: c.surface,
        onValueChanged: (v) => v == null ? null : onChanged(v),
        children: {
          for (final e in options.entries)
            e.key: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: Text(
                e.value,
                style: TextStyle(fontSize: 13, color: c.text),
              ),
            ),
        },
      );
    }
    return SegmentedButton<T>(
      showSelectedIcon: false,
      selected: {selected},
      onSelectionChanged: (s) => onChanged(s.first),
      segments: [
        for (final e in options.entries)
          ButtonSegment(value: e.key, label: Text(e.value)),
      ],
    );
  }
}
