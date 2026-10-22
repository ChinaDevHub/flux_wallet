import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/settings/domain/entities/backup_exception.dart';

/// New phone: bring the data back from an exported JSON instead of starting over.
class RestoreBackupButton extends StatelessWidget {
  const RestoreBackupButton({super.key});

  Future<void> _restore(BuildContext context) async {
    final import = context.read<AppDependencies>().useCases.importBackup;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await import();
    } on BackupException {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Bu fayl Flux Wallet ehtiyat nüsxəsi deyil.'),
        ),
      );
    } catch (_) {
      messenger.showSnackBar(const SnackBar(content: Text('Bərpa alınmadı.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _restore(context),
      child: Text(
        'Ehtiyat nüsxəsindən bərpa et',
        style: TextStyle(color: context.colors.primary),
      ),
    );
  }
}
