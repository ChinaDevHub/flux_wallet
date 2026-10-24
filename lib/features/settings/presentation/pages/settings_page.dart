import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/resume_listener.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/backup_section.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/data_section.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/bank_notifications_section.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/reminder_section.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/security_section.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/theme_section.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayarlar')),
      body: SafeArea(
        // Coming back from the system "notification access" screen.
        child: ResumeListener(
          onResume: context.read<SettingsCubit>().load,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            children: const [
              ThemeSection(),
              SizedBox(height: 20),
              SecuritySection(),
              SizedBox(height: 20),
              ReminderSection(),
              SizedBox(height: 20),
              BankNotificationsSection(),
              SizedBox(height: 20),
              BackupSection(),
              SizedBox(height: 20),
              DataSection(),
            ],
          ),
        ),
      ),
    );
  }
}
