import 'package:flutter/material.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/paste_message_form.dart';

/// Type or paste a bank text; [onSubmit] says whether it was understood.
class PasteMessageSheet extends StatefulWidget {
  const PasteMessageSheet({super.key, required this.onSubmit});

  final Future<bool> Function(String text) onSubmit;

  @override
  State<PasteMessageSheet> createState() => _PasteMessageSheetState();
}

class _PasteMessageSheetState extends State<PasteMessageSheet> {
  String _text = '';
  bool _failed = false;

  Future<void> _submit() async {
    final navigator = Navigator.of(context);
    if (await widget.onSubmit(_text)) {
      navigator.pop();
    } else if (mounted) {
      setState(() => _failed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: PasteMessageForm(
        failed: _failed,
        canSubmit: _text.trim().isNotEmpty,
        onChanged: (v) => setState(() {
          _text = v;
          _failed = false;
        }),
        onSubmit: _submit,
      ),
    );
  }
}
