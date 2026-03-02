import 'package:flutter/material.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/constants/lab_presets.dart';

class LabIconPicker extends StatelessWidget {
  const LabIconPicker({
    super.key,
    required this.selectedIconId,
    required this.onChanged,
  });

  final String selectedIconId;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Icon', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: AppSizes.spacingSm),
        Wrap(
          spacing: AppSizes.spacingXs,
          runSpacing: AppSizes.spacingXs,
          children: kLabIconOptions.map((option) {
            return ChoiceChip(
              selected: option.id == selectedIconId,
              avatar: Icon(option.icon, size: 18),
              label: Text(option.label),
              onSelected: (_) => onChanged(option.id),
            );
          }).toList(),
        ),
      ],
    );
  }
}
