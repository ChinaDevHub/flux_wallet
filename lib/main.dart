import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flux_wallet/app.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/core/files/app_files.dart';
import 'package:flux_wallet/features/home/data/demo_data_seeder.dart';

const _seedDemo = bool.fromEnvironment('SEED_DEMO');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppFiles.init();
  final deps = AppDependencies();
  if (_seedDemo) await seedDemoData(deps);
  runApp(FluxWalletApp(deps: deps));
  // The nudge survives reboots, but not a reinstall or a restored backup.
  unawaited(deps.useCases.eveningReminder.restore().catchError((_) {}));
}
