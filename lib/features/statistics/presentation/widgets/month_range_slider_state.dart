import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_range_slider.dart';
import 'package:flux_wallet/features/statistics/domain/entities/stats_range.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/knobs_for.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/range_ends.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/range_label.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/month_range_slider.dart';

/// Keeps the knobs under the finger; the range is reported on lift.
class MonthRangeSliderState extends State<MonthRangeSlider> {
  late RangeValues _v = knobsFor(widget.months, widget.range);

  DateTime _at(double v) => widget.months[v.round()];

  StatsRange _picked(RangeValues v) => StatsRange(_at(v.start), _at(v.end));

  @override
  void didUpdateWidget(MonthRangeSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.range == widget.range) return;
    _v = knobsFor(widget.months, widget.range);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdaptiveRangeSlider(
          values: _v,
          steps: widget.months.length,
          labels: RangeLabels(
            monthLabel(_at(_v.start)),
            monthLabel(_at(_v.end)),
          ),
          onChanged: (v) => setState(() => _v = v),
          onChangeEnd: (v) => widget.onRange(_picked(v)),
        ),
        RangeEnds(range: _picked(_v)),
      ],
    );
  }
}
