import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/routing/route_paths.dart';
import 'package:mobile/core/widgets/app_async_view.dart';
import 'package:mobile/core/widgets/app_empty_state.dart';
import 'package:mobile/core/widgets/app_error_state.dart';
import 'package:mobile/features/auth/presentation/controllers/auth_gate_controller.dart';
import 'package:mobile/features/experiments/presentation/models/experiment_form_prefill.dart';
import 'package:mobile/features/gallery/domain/entities/gallery_category_section.dart';
import 'package:mobile/features/gallery/domain/entities/gallery_template.dart';
import 'package:mobile/features/gallery/presentation/providers/gallery_providers.dart';
import 'package:mobile/features/gallery/presentation/widgets/gallery_template_detail_sheet.dart';
import 'package:mobile/features/labs/domain/entities/lab.dart';
import 'package:mobile/features/labs/presentation/providers/labs_providers.dart';

class GalleryTabScreen extends ConsumerWidget {
  const GalleryTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrap = ref.watch(authGateBootstrapProvider);

    return bootstrap.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object error, StackTrace stackTrace) {
        return AppErrorState(message: error.toString());
      },
      data: (_) {
        final featuredAsync = ref.watch(featuredTemplatesProvider);
        final sectionsAsync = ref.watch(galleryCategorySectionsProvider);

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(featuredTemplatesProvider);
            ref.invalidate(galleryCategorySectionsProvider);
          },
          child: ListView(
            padding: const EdgeInsets.all(AppSizes.spacingMd),
            children: <Widget>[
              Text('Featured', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSizes.spacingSm),
              AppAsyncView<List<GalleryTemplate>>(
                value: featuredAsync,
                data: (featured) {
                  if (featured.isEmpty) {
                    return const SizedBox(
                      height: 140,
                      child: AppEmptyState(
                        title: 'No featured templates',
                        message: 'Featured experiments will appear here.',
                        icon: Icons.star_outline,
                      ),
                    );
                  }

                  return Column(
                    children: featured
                        .map(
                          (template) => _TemplateTile(
                            template: template,
                            onTap: () =>
                                _openTemplateSheet(context, ref, template),
                            dense: false,
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              const SizedBox(height: AppSizes.spacingMd),
              AppAsyncView<List<GalleryCategorySection>>(
                value: sectionsAsync,
                data: (sections) {
                  if (sections.isEmpty) {
                    return const SizedBox(
                      height: 220,
                      child: AppEmptyState(
                        title: 'Gallery is empty',
                        message:
                            'Experiment templates from Firestore will appear here.',
                        icon: Icons.photo_library_outlined,
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: sections.map((section) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppSizes.spacingMd,
                        ),
                        child: _CategoryRail(
                          section: section,
                          onTemplateTap: (template) {
                            _openTemplateSheet(context, ref, template);
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openTemplateSheet(
    BuildContext context,
    WidgetRef ref,
    GalleryTemplate template,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return GalleryTemplateDetailSheet(
          template: template,
          onStartNow: () async {
            Navigator.of(sheetContext).pop();
            await _startNow(context, ref, template);
          },
        );
      },
    );
  }

  Future<void> _startNow(
    BuildContext context,
    WidgetRef ref,
    GalleryTemplate template,
  ) async {
    final cachedLabs = ref.read(currentUserLabsProvider).asData?.value;
    final List<Lab> labs =
        cachedLabs ?? await ref.read(currentUserLabsProvider.future);

    if (!context.mounted) {
      return;
    }

    if (labs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No lab found. Create a lab first.')),
      );
      return;
    }

    final prefill = ExperimentFormPrefill.fromTemplate(template);
    await context.push(RoutePaths.experimentNew(labs.first.id), extra: prefill);
  }
}

class _CategoryRail extends StatelessWidget {
  const _CategoryRail({required this.section, required this.onTemplateTap});

  final GalleryCategorySection section;
  final ValueChanged<GalleryTemplate> onTemplateTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(section.category, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSizes.spacingSm),
        SizedBox(
          height: 132,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final template = section.templates[index];
              return SizedBox(
                width: 260,
                child: _TemplateTile(
                  template: template,
                  onTap: () => onTemplateTap(template),
                  dense: true,
                ),
              );
            },
            separatorBuilder: (_, index) =>
                const SizedBox(width: AppSizes.spacingSm),
            itemCount: section.templates.length,
          ),
        ),
      ],
    );
  }
}

class _TemplateTile extends StatelessWidget {
  const _TemplateTile({
    required this.template,
    required this.onTap,
    required this.dense,
  });

  final GalleryTemplate template;
  final VoidCallback onTap;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingSm),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.spacingMd,
          vertical: dense ? AppSizes.spacingXs : AppSizes.spacingSm,
        ),
        leading: CircleAvatar(child: Icon(_iconForId(template.iconId))),
        title: Text(template.name),
        subtitle: Text(
          '${template.durationValue} ${template.durationUnit} · ${template.frequency}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  IconData _iconForId(String iconId) {
    switch (iconId) {
      case 'finance':
        return Icons.savings_outlined;
      case 'health':
        return Icons.favorite_border;
      case 'minimalism':
        return Icons.checkroom_outlined;
      case 'creativity':
        return Icons.palette_outlined;
      case 'challenge':
        return Icons.bolt_outlined;
      case 'mind':
        return Icons.self_improvement_outlined;
      default:
        return Icons.explore_outlined;
    }
  }
}
