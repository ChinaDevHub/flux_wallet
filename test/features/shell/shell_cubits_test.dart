import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/shell/presentation/widgets/shell_cubits.dart';

void main() {
  test('every shell cubit is registered under its own type', () {
    // A bare `BlocProvider` in a list registers as `dynamic`, and then
    // `context.read<ShellTabCubit>()` fails at runtime.
    final deps = AppDependencies(database: AppDatabase(path: ':memory:'));
    final names = shellCubits(deps).map((p) => '${p.runtimeType}').toList();
    expect(names, [
      'BlocProvider<ShellTabCubit>',
      'BlocProvider<ProfileCubit>',
      'BlocProvider<NoticesCubit>',
      'BlocProvider<HomeCubit>',
      'BlocProvider<TimelineCubit>',
      'BlocProvider<DebtsCubit>',
      'BlocProvider<StatisticsCubit>',
    ]);
  });
}
