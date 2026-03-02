import 'package:flutter/material.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/features/gallery/domain/entities/gallery_template.dart';

class GalleryTemplateDetailSheet extends StatelessWidget {
  const GalleryTemplateDetailSheet({
    super.key,
    required this.template,
    required this.onStartNow,
  });

  final GalleryTemplate template;
  final VoidCallback onStartNow;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(template.name, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSizes.spacingXs),
            Text(template.category),
            const SizedBox(height: AppSizes.spacingMd),
            Text(template.description),
            const SizedBox(height: AppSizes.spacingMd),
            _meta(
              'Duration',
              '${template.durationValue} ${template.durationUnit}',
            ),
            _meta('Frequency', template.frequency),
            _meta('Hypothesis', template.hypothesis),
            const SizedBox(height: AppSizes.spacingMd),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onStartNow,
                child: const Text('Start Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _meta(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 88, child: Text(label)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
