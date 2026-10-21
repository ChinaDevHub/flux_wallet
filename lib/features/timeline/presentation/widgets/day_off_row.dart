import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/app_switch.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// "Bu gün işə getmirəm" switch; applies immediately via [onChanged].
class DayOffRow extends StatefulWidget {
  const DayOffRow({super.key, required this.initial, required this.onChanged});

  final bool initial;
  final ValueChanged<bool> onChanged;

  @override
  State<DayOffRow> createState() => _DayOffRowState();
}

class _DayOffRowState extends State<DayOffRow> {
  late bool _value = widget.initial;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bu gün işə getmirəm',
                style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
              ),
              Text(
                'İş günü xərcləri bu gün üçün söndürülür',
                style: TextStyle(fontSize: 12, color: c.textMuted),
              ),
            ],
          ),
        ),
        AppSwitch(
          value: _value,
          onChanged: (v) {
            setState(() => _value = v);
            widget.onChanged(v);
          },
        ),
      ],
    );
  }
}
