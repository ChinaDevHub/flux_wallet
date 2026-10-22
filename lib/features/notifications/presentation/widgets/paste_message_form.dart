import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/widgets/app_text_field.dart';
import 'package:flux_wallet/core/widgets/primary_button.dart';

class PasteMessageForm extends StatelessWidget {
  const PasteMessageForm({
    super.key,
    required this.failed,
    required this.canSubmit,
    required this.onChanged,
    required this.onSubmit,
  });

  final bool failed, canSubmit;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        AppTextField(
          label: 'Bank mətni',
          hint: 'Kart +1234: BOLT.EU 4.80 AZN 20.10 08:42',
          onChanged: onChanged,
        ),
        if (failed)
          Text(
            'Mətndə AZN məbləği tapılmadı.',
            style: TextStyle(color: context.colors.negative),
          ),
        PrimaryButton(
          label: 'Növbəyə əlavə et',
          onPressed: canSubmit ? onSubmit : null,
        ),
      ],
    );
  }
}
