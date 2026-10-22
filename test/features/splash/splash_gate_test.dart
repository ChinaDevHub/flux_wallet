import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/theme/app_theme.dart';
import 'package:flux_wallet/features/auth/domain/usecases/resolve_session.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/session_cubit.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_gate.dart';
import '../../support/pump_for.dart';
import '../../support/fake_session_cubit.dart';

Future<FakeSessionCubit> pumpGate(
  WidgetTester t, {
  bool reduceMotion = false,
}) async {
  final session = FakeSessionCubit();
  await t.pumpWidget(
    BlocProvider<SessionCubit>.value(
      value: session,
      child: MaterialApp(
        theme: AppTheme.light,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(disableAnimations: reduceMotion),
          child: child!,
        ),
        home: const SplashGate(child: Text('app')),
      ),
    ),
  );
  return session;
}

void main() {
  testWidgets('plays the splash first; the app is built once the logo lands', (
    t,
  ) async {
    await pumpGate(t);
    await t.pump();
    expect(find.text('Flux Wallet'), findsOneWidget);
    expect(find.text('app'), findsNothing);
    await pumpFor(t, 1000);
    expect(find.text('app'), findsOneWidget);
    expect(find.text('Flux Wallet'), findsOneWidget);
    await pumpFor(t, 3000);
  });

  testWidgets('stays until the session is known, then hands over', (t) async {
    final session = await pumpGate(t);
    await pumpFor(t, 3000);
    expect(find.text('Flux Wallet'), findsOneWidget);
    session.emit(SessionState.signedOut);
    await t.pump();
    await pumpFor(t, 600);
    expect(find.text('Flux Wallet'), findsNothing);
    expect(find.text('app'), findsOneWidget);
  });

  testWidgets('with reduced motion it skips straight to the end', (t) async {
    final session = await pumpGate(t, reduceMotion: true);
    session.emit(SessionState.ready);
    await t.pump();
    await pumpFor(t, 300);
    await pumpFor(t, 600);
    expect(find.text('Flux Wallet'), findsNothing);
    expect(find.text('app'), findsOneWidget);
    expect(t.takeException(), isNull);
  });
}
