import 'package:flutter/material.dart';

/// "Bəli, əvəz et" / "Əlavə xərcdir"; the chosen one is filled.
class BusAnswerButtons extends StatelessWidget {
  const BusAnswerButtons({
    super.key,
    required this.answer,
    required this.onAnswer,
  });

  final bool? answer;
  final ValueChanged<bool> onAnswer;

  @override
  Widget build(BuildContext context) {
    Widget option(String label, bool value) {
      void tap() => onAnswer(value);

      return Expanded(
        child: answer == value
            ? FilledButton(onPressed: tap, child: Text(label))
            : OutlinedButton(onPressed: tap, child: Text(label)),
      );
    }

    return Row(
      spacing: 8,
      children: [option('Bəli, əvəz et', true), option('Əlavə xərcdir', false)],
    );
  }
}
