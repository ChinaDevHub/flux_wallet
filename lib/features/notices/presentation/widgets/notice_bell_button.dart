import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/icons/nav_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/notices/domain/entities/notice.dart';
import 'package:flux_wallet/features/notices/presentation/cubit/notices_cubit.dart';
import 'package:flux_wallet/features/notices/presentation/pages/open_notices_page.dart';

/// The top-bar bell: a count badge while something needs attention.
class NoticeBellButton extends StatelessWidget {
  const NoticeBellButton({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocBuilder<NoticesCubit, List<Notice>>(
      builder: (context, notices) => IconButton(
        tooltip: 'Bildirişlər',
        onPressed: () => openNoticesPage(context),
        icon: Badge.count(
          count: notices.length,
          isLabelVisible: notices.isNotEmpty,
          backgroundColor: c.negative,
          child: Icon(NavIcons.bell, color: c.text),
        ),
      ),
    );
  }
}
