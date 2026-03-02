import 'package:flutter/material.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/constants/lab_presets.dart';
import 'package:mobile/core/utils/color_utils.dart';

class LabColorPicker extends StatelessWidget {
  const LabColorPicker({
    super.key,
    required this.selectedColorHex,
    required this.onChanged,
  });

  final String selectedColorHex;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Cover color', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: AppSizes.spacingSm),
        Wrap(
          spacing: AppSizes.spacingSm,
          runSpacing: AppSizes.spacingSm,
          children: kLabColorPalette.map((hex) {
            final selected = hex == selectedColorHex;
            return GestureDetector(
              onTap: () => onChanged(hex),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: ColorUtils.fromHex(hex),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: selected
                        ? Theme.of(context).colorScheme.onSurface
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
