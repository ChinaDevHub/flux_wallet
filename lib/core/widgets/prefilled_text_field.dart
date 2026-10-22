import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/app_text_field.dart';
import 'package:flux_wallet/core/widgets/field_kind.dart';

/// An [AppTextField] that starts with [initial] and owns its controller.
class PrefilledTextField extends StatefulWidget {
  const PrefilledTextField({
    super.key,
    required this.initial,
    required this.label,
    required this.onChanged,
    this.kind = FieldKind.text,
    this.errorText,
  });

  final String initial, label;
  final FieldKind kind;
  final String? errorText;
  final ValueChanged<String> onChanged;

  @override
  State<PrefilledTextField> createState() => _PrefilledTextFieldState();
}

class _PrefilledTextFieldState extends State<PrefilledTextField> {
  late final _controller = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AppTextField(
    controller: _controller,
    label: widget.label,
    kind: widget.kind,
    errorText: widget.errorText,
    onChanged: widget.onChanged,
  );
}
