import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flux_wallet/app.dart';
import 'package:flux_wallet/app_boot.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/home/data/demo_data_seeder.dart';

const _seedDemo = bool.fromEnvironment('SEED_DEMO');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final deps = AppDependencies();
  if (_seedDemo) await seedDemoData(deps);
  final boot = await AppBoot.load(deps);
  runApp(
    FluxWalletApp(
      deps: deps,
      boot: boot,
      // Heavy and not urgent: only once the splash is over. The nudge
      // survives reboots, but not a reinstall or a restored backup.
      onRevealed: () =>
          unawaited(deps.useCases.eveningReminder.restore().catchError((_) {})),
    ),
  );
}
