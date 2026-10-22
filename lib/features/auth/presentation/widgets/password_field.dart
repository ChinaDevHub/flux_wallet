import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/app_text_field.dart';
import 'package:flux_wallet/core/widgets/field_kind.dart';

/// A password input with a show/hide eye.
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.label,
    required this.onChanged,
    this.errorText,
    this.action,
    this.onSubmitted,
  });

  final String label;
  final String? errorText;
  final TextInputAction? action;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: widget.label,
      kind: _hidden ? FieldKind.password : FieldKind.text,
      errorText: widget.errorText,
      action: widget.action,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      trailing: IconButton(
        tooltip: _hidden ? 'Göstər' : 'Gizlət',
        icon: Icon(
          _hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        ),
        onPressed: () => setState(() => _hidden = !_hidden),
      ),
    );
  }
}
