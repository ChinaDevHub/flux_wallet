import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/notices/domain/entities/notice.dart';
import 'package:flux_wallet/features/notices/presentation/cubit/notices_cubit.dart';
import 'package:flux_wallet/features/notices/presentation/widgets/empty_notices.dart';
import 'package:flux_wallet/features/notices/presentation/widgets/notice_tile.dart';
import 'package:flux_wallet/features/notices/presentation/widgets/open_notice.dart';

/// Everything that currently needs the user's attention.
class NoticesPage extends StatelessWidget {
  const NoticesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bildirişlər')),
      body: SafeArea(
        child: BlocBuilder<NoticesCubit, List<Notice>>(
          builder: (context, notices) => notices.isEmpty
              ? const EmptyNotices()
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  itemCount: notices.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (_, i) => NoticeTile(
                    notice: notices[i],
                    onTap: () => openNotice(context, notices[i]),
                  ),
                ),
        ),
      ),
    );
  }
}
