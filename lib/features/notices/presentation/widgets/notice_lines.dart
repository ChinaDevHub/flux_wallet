import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/notices/domain/entities/notice.dart';
import 'package:flux_wallet/features/notices/presentation/widgets/notice_text.dart';

/// Title and detail of a notice.
class NoticeLines extends StatelessWidget {
  const NoticeLines(this.notice, {super.key});

  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          notice.title,
          style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
        ),
        Text(notice.detail, style: TextStyle(fontSize: 13, color: c.textMuted)),
      ],
    );
  }
}
