import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/security/presentation/cubit/pin_flow_cubit.dart';
import 'package:flux_wallet/features/security/presentation/cubit/pin_flow_state.dart';
import 'package:flux_wallet/features/security/presentation/pages/pin_setup_page.dart';

/// Opens the PIN flow as a full-screen dialog (slides up on iOS).
Future<void> openPinSetup(BuildContext context, PinFlowMode mode) {
  final pin = context.read<AppDependencies>().useCases.appPin;
  return Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (_) => BlocProvider(
        create: (_) => PinFlowCubit(pin, mode)..init(),
        child: PinSetupPage(mode: mode),
      ),
    ),
  );
}
