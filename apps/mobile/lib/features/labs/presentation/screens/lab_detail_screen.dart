import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/constants/lab_presets.dart';
import 'package:mobile/core/routing/route_paths.dart';
import 'package:mobile/core/utils/color_utils.dart';
import 'package:mobile/core/widgets/app_async_view.dart';
import 'package:mobile/core/widgets/app_empty_state.dart';
import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/experiments/presentation/providers/experiments_providers.dart';
import 'package:mobile/features/labs/domain/entities/lab.dart';
import 'package:mobile/features/labs/domain/entities/lab_stats.dart';
import 'package:mobile/features/labs/presentation/controllers/labs_action_controller.dart';
import 'package:mobile/features/labs/presentation/providers/labs_providers.dart';

class LabDetailScreen extends ConsumerWidget {
  const LabDetailScreen({super.key, required this.labId});

  final String labId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(labsActionControllerProvider, (_, next) {
      next.whenOrNull(
        error: (Object error, StackTrace stackTrace) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    final labAsync = ref.watch(labByIdProvider(labId));

    return AppAsyncView<Lab?>(
      value: labAsync,
      data: (Lab? lab) {
        if (lab == null) {
          return const Scaffold(
            body: AppEmptyState(
              title: 'Lab not found',
              message: 'This lab may have been deleted.',
            ),
          );
        }

        return _LabDetailBody(lab: lab);
      },
    );
  }
}

class _LabDetailBody extends ConsumerWidget {
  const _LabDetailBody({required this.lab});

  final Lab lab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(labStatsProvider(lab.id));
    final experimentsAsync = ref.watch(labExperimentsProvider(lab.id));

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 14,
              backgroundColor: ColorUtils.fromHex(lab.colorHex),
              child: Icon(
                _iconForLab(lab.iconId),
                size: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: AppSizes.spacingSm),
            Flexible(child: Text(lab.name)),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => context.push(RoutePaths.labEdit(lab.id)),
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit lab',
          ),
          IconButton(
            onPressed: () => _handleDelete(context, ref),
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete lab',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(RoutePaths.experimentNew(lab.id)),
        icon: const Icon(Icons.add),
        label: const Text('New Experiment'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        children: <Widget>[
          if ((lab.description ?? '').isNotEmpty) ...<Widget>[
            Text(
              lab.description!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSizes.spacingMd),
          ],
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.spacingMd),
              child: AppAsyncView<LabStats>(
                value: statsAsync,
                data: (LabStats stats) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _StatColumn(
                        title: 'Total Experiments',
                        value: stats.totalExperiments.toString(),
                      ),
                      _StatColumn(
                        title: 'Completed',
                        value: stats.totalCompleted.toString(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spacingMd),
          Text(
            'Ongoing Experiments',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSizes.spacingSm),
          AppAsyncView<List<Experiment>>(
            value: experimentsAsync,
            data: (List<Experiment> experiments) {
              if (experiments.isEmpty) {
                return const SizedBox(
                  height: 180,
                  child: AppEmptyState(
                    title: 'No ongoing experiments',
                    message: 'Create your first experiment in this lab.',
                    icon: Icons.science_outlined,
                  ),
                );
              }

              return Column(
                children: experiments.map((experiment) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: AppSizes.spacingSm),
                    child: ListTile(
                      title: Text(experiment.name),
                      subtitle: Text(experiment.status.label),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        context.push(
                          RoutePaths.experimentDetail(experiment.id),
                        );
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
  }

  Future<void> _handleDelete(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete lab'),
          content: const Text(
            'Delete this lab? This is blocked if experiments still exist in it.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm != true || !context.mounted) {
      return;
    }

    final result = await ref
        .read(labsActionControllerProvider.notifier)
        .deleteLabIfAllowed(lab.id);

    if (!context.mounted) {
      return;
    }

    if (!result.canDelete) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.reason ?? 'This lab cannot be deleted right now.',
          ),
        ),
      );
      return;
    }

    context.pop();
  }

  IconData _iconForLab(String iconId) {
    for (final option in kLabIconOptions) {
      if (option.id == iconId) {
        return option.icon;
      }
    }
    return Icons.science_outlined;
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(value, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: AppSizes.spacingXs),
        Text(title, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
