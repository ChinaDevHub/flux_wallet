import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/section_label.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

class FrequencyChips extends StatelessWidget {
  const FrequencyChips({
    super.key,
    required this.selected,
    required this.onChanged,
    this.title = 'Təkrarla',
    this.allowNone = true,
  });

  static const _labels = <Frequency?, String>{
    null: 'Yox',
    Frequency.daily: 'Hər gün',
    Frequency.weekdays: 'İş günləri',
    Frequency.weekly: 'Həftəlik',
    Frequency.monthly: 'Aylıq',
  };

  final Frequency? selected;
  final ValueChanged<Frequency?> onChanged;
  final String title;
  final bool allowNone;

  @override
  Widget build(BuildContext context) {
    final options = _labels.entries.where((e) => allowNone || e.key != null);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        SectionLabel(title),
        Wrap(
          spacing: 8,
          children: [
            for (final e in options)
              ChoiceChip(
                label: Text(e.value),
                selected: selected == e.key,
                showCheckmark: false,
                onSelected: (_) => onChanged(e.key),
              ),
          ],
        ),
      ],
    );
  }
}
