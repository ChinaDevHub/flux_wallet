import 'package:flutter/material.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/daily_cap_form.dart';

/// Set, change or remove the daily cap. [onSave] gets a valid amount;
/// [onClear] removes it (offered only while one is set).
class DailyCapSheet extends StatefulWidget {
  const DailyCapSheet({
    super.key,
    required this.current,
    required this.onSave,
    required this.onClear,
  });

  final double? current;
  final ValueChanged<double> onSave;
  final VoidCallback onClear;

  @override
  State<DailyCapSheet> createState() => _DailyCapSheetState();
}

class _DailyCapSheetState extends State<DailyCapSheet> {
  late final _controller = TextEditingController(
    text: widget.current == null ? '' : formatPlain(widget.current!),
  );

  double? get _amount {
    final v = parseMoney(_controller.text);
    return v != null && v > 0 ? v : null;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DailyCapForm(
    controller: _controller,
    amount: _amount,
    canClear: widget.current != null,
    onChanged: () => setState(() {}),
    onSave: () => widget.onSave(_amount!),
    onClear: widget.onClear,
  );
}
