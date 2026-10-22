import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/arrow_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/notices/domain/entities/notice.dart';
import 'package:flux_wallet/features/notices/presentation/widgets/notice_lines.dart';
import 'package:flux_wallet/features/notices/presentation/widgets/notice_style.dart';

/// One row of the notification list.
class NoticeTile extends StatelessWidget {
  const NoticeTile({super.key, required this.notice, required this.onTap});

  final Notice notice;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final tint = notice.kind.tint(c);
    return Material(
      color: c.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            spacing: 12,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: tint.withAlpha(36),
                child: Icon(notice.kind.icon, color: tint, size: 20),
              ),
              Expanded(child: NoticeLines(notice)),
              Icon(ArrowIcons.next, color: c.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
