import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debts_cubit.dart';
import 'package:flux_wallet/features/home/presentation/cubit/home_cubit.dart';
import 'package:flux_wallet/features/notices/presentation/cubit/notices_cubit.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flux_wallet/features/profile/presentation/pages/open_profile_page.dart';
import 'package:flux_wallet/features/shell/presentation/cubit/shell_tab_cubit.dart';
import 'package:flux_wallet/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_cubit.dart';

/// The cubits that live as long as a user is signed in. Each provider names
/// its type: a bare `BlocProvider` in a list would register as `dynamic`.
List<BlocProvider> shellCubits(AppDependencies deps) {
  final u = deps.useCases;
  return [
    BlocProvider<ShellTabCubit>(create: (_) => ShellTabCubit()),
    BlocProvider<ProfileCubit>(create: (_) => newProfileCubit(deps)..load()),
    BlocProvider<NoticesCubit>(
      create: (_) => NoticesCubit(u.loadNotices, deps.changes)..load(),
    ),
    BlocProvider<HomeCubit>(
      create: (_) => HomeCubit(u.loadHome, deps.changes)..load(),
    ),
    BlocProvider<TimelineCubit>(
      create: (_) =>
          TimelineCubit(u.loadTimeline, u.scheduleEditor, deps.changes)..load(),
    ),
    BlocProvider<DebtsCubit>(create: (_) => newDebtsCubit(deps)),
    BlocProvider<StatisticsCubit>(
      create: (_) => StatisticsCubit(u.loadStatistics, deps.changes)..load(),
    ),
  ];
}
