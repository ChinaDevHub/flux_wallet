import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/amount_text_field.dart';

/// The big amount input that starts with [initial] and owns its controller.
class PrefilledAmountField extends StatefulWidget {
  const PrefilledAmountField({
    super.key,
    required this.initial,
    required this.onChanged,
  });

  final String initial;
  final ValueChanged<String> onChanged;

  @override
  State<PrefilledAmountField> createState() => _PrefilledAmountFieldState();
}

class _PrefilledAmountFieldState extends State<PrefilledAmountField> {
  late final _controller = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      AmountTextField(controller: _controller, onChanged: widget.onChanged);
}
