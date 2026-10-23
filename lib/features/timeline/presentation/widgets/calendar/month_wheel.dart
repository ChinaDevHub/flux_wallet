import 'package:flutter/cupertino.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/az_calendar.dart';
import 'package:flux_wallet/core/widgets/sheet_done_button.dart';

/// iOS month picker: a wheel of every month the calendar covers.
class MonthWheel extends StatefulWidget {
  const MonthWheel({super.key, required this.months, required this.initial});

  final List<DateTime> months;
  final DateTime initial;

  @override
  State<MonthWheel> createState() => _MonthWheelState();
}

class _MonthWheelState extends State<MonthWheel> {
  late int _index = widget.months
      .indexWhere((m) => m == widget.initial)
      .clamp(0, widget.months.length - 1);

  TextStyle _style(BuildContext context) =>
      TextStyle(color: context.colors.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40,
              scrollController: FixedExtentScrollController(
                initialItem: _index,
              ),
              onSelectedItemChanged: (i) => _index = i,
              children: [
                for (final m in widget.months)
                  Center(child: Text(azMonthYear(m), style: _style(context))),
              ],
            ),
          ),
          SheetDoneButton(result: () => widget.months[_index]),
        ],
      ),
    );
  }
}
