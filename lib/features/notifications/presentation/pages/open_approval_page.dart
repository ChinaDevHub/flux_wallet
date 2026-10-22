import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_cubit.dart';
import 'package:flux_wallet/features/notifications/presentation/pages/approval_page.dart';

Future<void> openApprovalPage(BuildContext context) {
  final deps = context.read<AppDependencies>();
  final u = deps.useCases;
  return Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (_) => ApprovalCubit(
          u.loadPending,
          u.confirmPending,
          u.ingest,
          deps.changes,
        )..load(),
        child: const ApprovalPage(),
      ),
    ),
  );
}
