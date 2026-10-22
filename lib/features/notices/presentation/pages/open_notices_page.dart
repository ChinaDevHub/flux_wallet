import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/notices/presentation/cubit/notices_cubit.dart';
import 'package:flux_wallet/features/notices/presentation/pages/notices_page.dart';
import 'package:flux_wallet/features/shell/presentation/cubit/shell_tab_cubit.dart';

/// Pushed routes sit above the shell's providers, so hand the cubits over.
Future<void> openNoticesPage(BuildContext context) {
  final notices = context.read<NoticesCubit>();
  final tabs = context.read<ShellTabCubit>();
  return Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: notices),
          BlocProvider.value(value: tabs),
        ],
        child: const NoticesPage(),
      ),
    ),
  );
}
