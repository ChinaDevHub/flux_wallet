import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/theme/app_theme.dart';
import 'package:flux_wallet/features/notices/domain/entities/notice.dart';
import 'package:flux_wallet/features/notices/presentation/cubit/notices_cubit.dart';
import 'package:flux_wallet/features/notices/presentation/pages/notices_page.dart';
import 'package:flux_wallet/features/shell/presentation/cubit/shell_tab_cubit.dart';
import '../../support/fake_notices_cubit.dart';
import '../../support/pump_for.dart';

Future<ShellTabCubit> openPage(WidgetTester t, List<Notice> notices) async {
  final tabs = ShellTabCubit();
  await t.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<NoticesCubit>.value(value: FakeNoticesCubit(notices)),
        BlocProvider<ShellTabCubit>.value(value: tabs),
      ],
      child: MaterialApp(
        theme: AppTheme.light,
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<NoticesCubit>.value(
                      value: FakeNoticesCubit(notices),
                    ),
                    BlocProvider<ShellTabCubit>.value(value: tabs),
                  ],
                  child: const NoticesPage(),
                ),
              ),
            ),
            child: const Text('open'),
          ),
        ),
      ),
    ),
  );
  await t.tap(find.text('open'));
  await pumpFor(t, 500);
  return tabs;
}

void main() {
  testWidgets('nothing pending shows the all-clear', (t) async {
    await openPage(t, const []);
    expect(find.text('Hər şey qaydasındadır'), findsOneWidget);
  });

  testWidgets('lists the notices with their words', (t) async {
    await openPage(t, const [
      Notice(NoticeKind.debtDue, subject: 'Kamal', amount: 65, days: 1),
      Notice(NoticeKind.paymentDue, subject: 'Kirayə', amount: 300, days: 2),
    ]);
    expect(find.text('Kamal · borc ödənişi'), findsOneWidget);
    expect(find.text('Sabah · 65.00 ₼'), findsOneWidget);
    expect(find.text('Kirayə'), findsOneWidget);
    expect(find.text('2 gün sonra · 300.00 ₼'), findsOneWidget);
  });

  testWidgets('a bill sends the user to Timeline, a debt to Borclar', (
    t,
  ) async {
    final tabs = await openPage(t, const [
      Notice(NoticeKind.paymentDue, subject: 'Kirayə', amount: 300, days: 2),
    ]);
    await t.tap(find.text('Kirayə'));
    await t.pumpAndSettle();
    expect(tabs.state, 1);
    expect(find.text('Bildirişlər'), findsNothing);

    await t.tap(find.text('open'));
    await t.pumpAndSettle();
    expect(find.text('Kirayə'), findsOneWidget);
  });
}
