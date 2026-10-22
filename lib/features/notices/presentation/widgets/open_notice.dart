import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/notices/domain/entities/notice.dart';
import 'package:flux_wallet/features/notices/presentation/widgets/notice_style.dart';
import 'package:flux_wallet/features/notifications/presentation/pages/open_approval_page.dart';
import 'package:flux_wallet/features/shell/presentation/cubit/shell_tab_cubit.dart';

/// Takes the user to where the notice can be dealt with: the approval queue
/// or the matching main tab (closing the notification list).
void openNotice(BuildContext context, Notice notice) {
  final tab = notice.kind.tab;
  if (tab == null) {
    openApprovalPage(context);
    return;
  }
  context.read<ShellTabCubit>().select(tab);
  Navigator.pop(context);
}
