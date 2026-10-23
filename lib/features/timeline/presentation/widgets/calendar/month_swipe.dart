import 'package:flutter/widgets.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_state.dart';

/// A sideways fling over [child] moves one month, within the calendar.
class MonthSwipe extends StatelessWidget {
  const MonthSwipe({
    super.key,
    required this.state,
    required this.onMonth,
    required this.child,
  });

  final TimelineLoaded state;
  final ValueChanged<DateTime> onMonth;
  final Widget child;

  void _end(DragEndDetails d) {
    final v = d.primaryVelocity ?? 0;
    if (v.abs() < 200) return;
    final forward = v < 0;
    final m = state.month;
    final ok = forward
        ? state.bounds.hasMonthAfter(m)
        : state.bounds.hasMonthBefore(m);
    if (ok) onMonth(DateTime(m.year, m.month + (forward ? 1 : -1)));
  }

  @override
  Widget build(BuildContext context) =>
      GestureDetector(onHorizontalDragEnd: _end, child: child);
}
