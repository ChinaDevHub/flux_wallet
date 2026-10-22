import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/bus_answer_buttons.dart';

/// "Bu taksi avtobusu əvəz edir?" — asked before the taxi is booked.
class BusReplacePrompt extends StatelessWidget {
  const BusReplacePrompt({
    super.key,
    required this.answer,
    required this.onAnswer,
  });

  final bool? answer;
  final ValueChanged<bool> onAnswer;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: c.accentSoft,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            'Bu gün işdir. Bu taksi avtobusu əvəz edir?',
            style: TextStyle(fontWeight: FontWeight.w700, color: c.accent),
          ),
          Text(
            'Əvəz edirsə, həmin günün planlaşdırılmış avtobus xərci silinir '
            'və xərc iki dəfə sayılmır.',
            style: TextStyle(fontSize: 12, color: c.textMuted),
          ),
          BusAnswerButtons(answer: answer, onAnswer: onAnswer),
        ],
      ),
    );
  }
}
