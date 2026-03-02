import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/routing/route_paths.dart';
import 'package:mobile/core/widgets/app_async_view.dart';
import 'package:mobile/core/widgets/app_empty_state.dart';
import 'package:mobile/features/experiments/presentation/models/experiment_form_prefill.dart';
import 'package:mobile/features/gallery/domain/entities/gallery_template.dart';
import 'package:mobile/features/gallery/presentation/providers/gallery_providers.dart';
import 'package:mobile/features/gallery/presentation/widgets/gallery_template_detail_sheet.dart';
import 'package:mobile/features/labs/domain/entities/lab.dart';
import 'package:mobile/features/labs/presentation/providers/labs_providers.dart';

class GalleryTemplateScreen extends ConsumerWidget {
  const GalleryTemplateScreen({super.key, required this.templateId});

  final String templateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templateAsync = ref.watch(galleryTemplateByIdProvider(templateId));

    return AppAsyncView<GalleryTemplate?>(
      value: templateAsync,
      data: (template) {
        if (template == null) {
          return const Scaffold(
            body: AppEmptyState(
              title: 'Template not found',
              message: 'This gallery template is no longer available.',
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(template.name)),
          body: GalleryTemplateDetailSheet(
            template: template,
            onStartNow: () async {
              final cachedLabs = ref
                  .read(currentUserLabsProvider)
                  .asData
                  ?.value;
              final List<Lab> labs =
                  cachedLabs ?? await ref.read(currentUserLabsProvider.future);

              if (!context.mounted || labs.isEmpty) {
                return;
              }

              await context.push(
                RoutePaths.experimentNew(labs.first.id),
                extra: ExperimentFormPrefill.fromTemplate(template),
              );
            },
          ),
        );
      },
    );
  }
}
