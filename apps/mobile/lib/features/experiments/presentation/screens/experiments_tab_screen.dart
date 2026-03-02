import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/constants/app_strings.dart';
import 'package:mobile/core/constants/lab_presets.dart';
import 'package:mobile/core/routing/route_paths.dart';
import 'package:mobile/core/utils/color_utils.dart';
import 'package:mobile/core/widgets/app_async_view.dart';
import 'package:mobile/core/widgets/app_empty_state.dart';
import 'package:mobile/core/widgets/app_error_state.dart';
import 'package:mobile/features/auth/presentation/controllers/auth_gate_controller.dart';
import 'package:mobile/features/experiments/domain/entities/today_due_item.dart';
import 'package:mobile/features/experiments/presentation/providers/experiments_providers.dart';
import 'package:mobile/features/labs/domain/entities/lab.dart';
import 'package:mobile/features/labs/domain/entities/lab_stats.dart';
import 'package:mobile/features/labs/presentation/providers/labs_providers.dart';

class ExperimentsTabScreen extends ConsumerWidget {
  const ExperimentsTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrap = ref.watch(authGateBootstrapProvider);

    return bootstrap.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object error, StackTrace stackTrace) {
        return AppErrorState(message: error.toString());
      },
      data: (_) {
        ref.watch(syncCurrentUserExpiredExperimentsProvider);
        final labsAsync = ref.watch(currentUserLabsProvider);

        return AppAsyncView<List<Lab>>(
          value: labsAsync,
          data: (List<Lab> labs) {
            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(todayDueItemsProvider);
                ref.invalidate(currentUserLabsProvider);
                ref.invalidate(syncCurrentUserExpiredExperimentsProvider);
              },
              child: ListView(
                padding: const EdgeInsets.all(AppSizes.spacingMd),
                children: <Widget>[
                  const _TodayCard(),
                  const SizedBox(height: AppSizes.spacingMd),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Labs',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => context.push(RoutePaths.labsNew),
                        icon: const Icon(Icons.add),
                        label: const Text('New Lab'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacingSm),
                  if (labs.isEmpty)
                    const SizedBox(
                      height: 220,
                      child: AppEmptyState(
                        title: 'No labs yet',
                        message: 'Create a lab to start tracking experiments.',
                        icon: Icons.science_outlined,
                      ),
                    )
                  else
                    ...labs.map((Lab lab) => _LabCard(lab: lab)),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _TodayCard extends ConsumerWidget {
  const _TodayCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayAsync = ref.watch(todayDueItemsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Today', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSizes.spacingSm),
            AppAsyncView<List<TodayDueItem>>(
              value: todayAsync,
              data: (items) {
                if (items.isEmpty) {
                  return const Text(AppStrings.nothingDueToday);
                }

                return Column(
                  children: items.map((item) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        item.isCheckedInToday
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      ),
                      title: Text(item.experiment.name),
                      subtitle: Text(item.labName),
                      onTap: () {
                        context.push(
                          RoutePaths.experimentDetail(item.experiment.id),
                        );
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LabCard extends ConsumerWidget {
  const _LabCard({required this.lab});

  final Lab lab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(labStatsProvider(lab.id));

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingSm),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: ColorUtils.fromHex(lab.colorHex),
          child: Icon(_iconForId(lab.iconId), color: Colors.white),
        ),
        title: Text(lab.name),
        subtitle: AppAsyncView<LabStats>(
          value: statsAsync,
          data: (stats) {
            return Text(
              'Total experiments: ${stats.totalExperiments} · Completed: ${stats.totalCompleted}',
            );
          },
          loading: const Text('Loading stats...'),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          context.push(RoutePaths.labDetail(lab.id));
        },
      ),
    );
  }

  IconData _iconForId(String id) {
    for (final option in kLabIconOptions) {
      if (option.id == id) {
        return option.icon;
      }
    }
    return Icons.science_outlined;
  }
}
