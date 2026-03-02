import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/utils/date_utils.dart';
import 'package:mobile/core/widgets/app_async_view.dart';
import 'package:mobile/core/widgets/app_empty_state.dart';
import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/experiments/domain/entities/experiment_analytics.dart';
import 'package:mobile/features/experiments/presentation/controllers/experiment_action_controller.dart';
import 'package:mobile/features/experiments/presentation/providers/experiments_providers.dart';
import 'package:mobile/features/labs/presentation/providers/labs_providers.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

class ExperimentDetailScreen extends ConsumerStatefulWidget {
  const ExperimentDetailScreen({super.key, required this.experimentId});

  final String experimentId;

  @override
  ConsumerState<ExperimentDetailScreen> createState() =>
      _ExperimentDetailScreenState();
}

class _ExperimentDetailScreenState
    extends ConsumerState<ExperimentDetailScreen> {
  final _uuid = const Uuid();
  DateTime _focusedDay = AppDateUtils.startOfDay(DateTime.now());
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    Future<void>.microtask(() async {
      await ref.read(syncCurrentUserExpiredExperimentsProvider.future);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(experimentActionControllerProvider, (_, next) {
      next.whenOrNull(
        error: (Object error, StackTrace _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    final experimentAsync = ref.watch(
      experimentByIdProvider(widget.experimentId),
    );

    return AppAsyncView<Experiment?>(
      value: experimentAsync,
      data: (Experiment? experiment) {
        if (experiment == null) {
          return const Scaffold(
            body: AppEmptyState(
              title: 'Experiment not found',
              message: 'This experiment may have been deleted.',
            ),
          );
        }

        return _ExperimentDetailBody(
          experiment: experiment,
          focusedDay: _focusedDay,
          selectedDay: _selectedDay,
          onDaySelected: (selected, focused) {
            setState(() {
              _selectedDay = selected;
              _focusedDay = focused;
            });
          },
          onFocusedDayChanged: (focused) {
            setState(() => _focusedDay = focused);
          },
          createId: () => _uuid.v4(),
        );
      },
    );
  }
}

class _ExperimentDetailBody extends ConsumerWidget {
  const _ExperimentDetailBody({
    required this.experiment,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onFocusedDayChanged,
    required this.createId,
  });

  final Experiment experiment;
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final void Function(DateTime selected, DateTime focused) onDaySelected;
  final void Function(DateTime focused) onFocusedDayChanged;
  final String Function() createId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(
      experimentAnalyticsProvider(experiment.id),
    );
    final labAsync = ref.watch(labByIdProvider(experiment.labId));
    final actionBusy = ref.watch(experimentActionControllerProvider).isLoading;
    final passFailVisible = ref.watch(passFailFeatureVisibleProvider);

    return Scaffold(
      appBar: AppBar(title: Text(experiment.name)),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildMetaRow(
                    context,
                    'Status',
                    _statusChip(experiment.status),
                  ),
                  const SizedBox(height: AppSizes.spacingSm),
                  _buildMetaRow(
                    context,
                    'Lab',
                    Text(labAsync.asData?.value?.name ?? 'Lab'),
                  ),
                  const SizedBox(height: AppSizes.spacingSm),
                  _buildMetaRow(
                    context,
                    'Start',
                    Text(AppDateUtils.formatDate(experiment.startDate)),
                  ),
                  if (!experiment.isOpenEnded && experiment.endDate != null)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSizes.spacingSm),
                      child: _buildMetaRow(
                        context,
                        'End',
                        Text(AppDateUtils.formatDate(experiment.endDate!)),
                      ),
                    ),
                  const SizedBox(height: AppSizes.spacingSm),
                  _buildMetaRow(
                    context,
                    'Frequency',
                    Text(experiment.frequency.label),
                  ),
                ],
              ),
            ),
          ),
          if ((experiment.hypothesis ?? '').isNotEmpty) ...<Widget>[
            const SizedBox(height: AppSizes.spacingMd),
            _textSection(
              context,
              title: 'Hypothesis',
              body: experiment.hypothesis!,
            ),
          ],
          if ((experiment.motivation ?? '').isNotEmpty) ...<Widget>[
            const SizedBox(height: AppSizes.spacingMd),
            _textSection(
              context,
              title: 'Motivation',
              body: experiment.motivation!,
            ),
          ],
          if (experiment.interferenceLogEnabled &&
              (experiment.interferenceNote ?? '').isNotEmpty) ...<Widget>[
            const SizedBox(height: AppSizes.spacingMd),
            _textSection(
              context,
              title: 'Interference Note',
              body: experiment.interferenceNote!,
            ),
          ],
          const SizedBox(height: AppSizes.spacingMd),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonal(
              onPressed: experiment.status == ExperimentStatus.active
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Check-in flow will be added in Phase 3.',
                          ),
                        ),
                      );
                    }
                  : null,
              child: const Text('Check-in'),
            ),
          ),
          const SizedBox(height: AppSizes.spacingSm),
          _actionButtons(context, ref, actionBusy),
          if (passFailVisible &&
              experiment.status == ExperimentStatus.completed)
            Padding(
              padding: const EdgeInsets.only(top: AppSizes.spacingMd),
              child: _passFailControls(context, ref, actionBusy),
            ),
          const SizedBox(height: AppSizes.spacingMd),
          _subtasksSection(context, ref, actionBusy),
          const SizedBox(height: AppSizes.spacingMd),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.spacingMd),
              child: AppAsyncView<ExperimentAnalytics>(
                value: analyticsAsync,
                data: (analytics) => _timelineSection(context, analytics),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButtons(BuildContext context, WidgetRef ref, bool actionBusy) {
    final controller = ref.read(experimentActionControllerProvider.notifier);

    final children = <Widget>[];

    if (experiment.status == ExperimentStatus.active) {
      children.add(
        Expanded(
          child: FilledButton.tonal(
            onPressed: actionBusy
                ? null
                : () => controller.pause(experiment.id),
            child: const Text('Pause'),
          ),
        ),
      );
    }

    if (experiment.status == ExperimentStatus.paused) {
      children.add(
        Expanded(
          child: FilledButton.tonal(
            onPressed: actionBusy
                ? null
                : () => controller.resume(experiment.id),
            child: const Text('Resume'),
          ),
        ),
      );
    }

    if (experiment.status == ExperimentStatus.active ||
        experiment.status == ExperimentStatus.paused) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(width: AppSizes.spacingSm));
      }
      children.add(
        Expanded(
          child: OutlinedButton(
            onPressed: actionBusy
                ? null
                : () => _confirmEndExperiment(context, ref, experiment.id),
            child: const Text('End Experiment'),
          ),
        ),
      );
    }

    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(children: children);
  }

  Widget _passFailControls(
    BuildContext context,
    WidgetRef ref,
    bool actionBusy,
  ) {
    final current = experiment.passFailResult;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Pass / Fail', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSizes.spacingSm),
            Wrap(
              spacing: AppSizes.spacingSm,
              children: PassFailResult.values.map((result) {
                return ChoiceChip(
                  label: Text(result.label),
                  selected: current == result,
                  onSelected: actionBusy
                      ? null
                      : (selected) {
                          ref
                              .read(experimentActionControllerProvider.notifier)
                              .setPassFail(
                                experiment.id,
                                selected ? result : null,
                              );
                        },
                );
              }).toList(),
            ),
            if (current != null)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: actionBusy
                      ? null
                      : () {
                          ref
                              .read(experimentActionControllerProvider.notifier)
                              .setPassFail(experiment.id, null);
                        },
                  child: const Text('Clear result'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _subtasksSection(
    BuildContext context,
    WidgetRef ref,
    bool actionBusy,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Subtasks',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                TextButton.icon(
                  onPressed: actionBusy
                      ? null
                      : () => _addSubtaskDialog(context, ref),
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spacingSm),
            if (experiment.subtasks.isEmpty)
              const Text('No subtasks added.')
            else
              ...experiment.subtasks.asMap().entries.map((entry) {
                final index = entry.key;
                final subtask = entry.value;

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(subtask.name),
                  subtitle: Text('Order ${subtask.order + 1}'),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_upward),
                    onPressed: actionBusy || index == 0
                        ? null
                        : () => _moveSubtask(ref, index, index - 1),
                  ),
                  trailing: Wrap(
                    spacing: 0,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.arrow_downward),
                        onPressed:
                            actionBusy ||
                                index == experiment.subtasks.length - 1
                            ? null
                            : () => _moveSubtask(ref, index, index + 1),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: actionBusy
                            ? null
                            : () => _editSubtaskDialog(context, ref, subtask),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: actionBusy
                            ? null
                            : () => _deleteSubtask(ref, subtask.id),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _timelineSection(BuildContext context, ExperimentAnalytics analytics) {
    final firstDay = experiment.startDate.subtract(const Duration(days: 30));
    final lastBound = _maxDate(
      experiment.endDate ?? DateTime.now(),
      DateTime.now().add(const Duration(days: 120)),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Timeline', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSizes.spacingSm),
        TableCalendar<void>(
          firstDay: AppDateUtils.startOfDay(firstDay),
          lastDay: AppDateUtils.startOfDay(lastBound),
          focusedDay: focusedDay,
          selectedDayPredicate: (day) {
            return selectedDay != null &&
                AppDateUtils.isSameDay(day, selectedDay!);
          },
          onDaySelected: onDaySelected,
          onPageChanged: onFocusedDayChanged,
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              return _dayCell(context, day, analytics.dayStates, false);
            },
            todayBuilder: (context, day, focusedDay) {
              return _dayCell(context, day, analytics.dayStates, true);
            },
            selectedBuilder: (context, day, focusedDay) {
              final state = _stateForDay(day, analytics.dayStates);
              final color = _colorForState(state, context);
              return Container(
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color, width: 1.4),
                ),
                child: Center(child: Text('${day.day}')),
              );
            },
          ),
        ),
        const SizedBox(height: AppSizes.spacingSm),
        Wrap(
          spacing: AppSizes.spacingSm,
          runSpacing: AppSizes.spacingXs,
          children: <Widget>[
            _legend(context, 'Completed', CalendarDayState.completed),
            _legend(context, 'Backfill', CalendarDayState.backfill),
            _legend(context, 'Missed', CalendarDayState.missed),
            _legend(context, 'Rest', CalendarDayState.rest),
            _legend(context, 'Pending', CalendarDayState.duePending),
          ],
        ),
        const SizedBox(height: AppSizes.spacingMd),
        Wrap(
          spacing: AppSizes.spacingSm,
          runSpacing: AppSizes.spacingSm,
          children: <Widget>[
            _metricCard(
              context,
              'Completion',
              '${analytics.completionPercent.toStringAsFixed(1)}%',
            ),
            _metricCard(
              context,
              'Current Streak',
              analytics.currentStreak.toString(),
            ),
            _metricCard(
              context,
              'Best Streak',
              analytics.bestStreak.toString(),
            ),
            _metricCard(
              context,
              'Total Completed',
              analytics.totalDaysCompleted.toString(),
            ),
            if (experiment.frequency == ExperimentFrequency.daily)
              _metricCard(
                context,
                'Missed Days',
                analytics.missedDays.toString(),
              ),
          ],
        ),
      ],
    );
  }

  Widget? _dayCell(
    BuildContext context,
    DateTime day,
    Map<String, CalendarDayState> dayStates,
    bool isToday,
  ) {
    final state = _stateForDay(day, dayStates);
    if (state == null || state == CalendarDayState.notDue) {
      return null;
    }

    final color = _colorForState(state, context);
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isToday ? 0.34 : 0.24),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  CalendarDayState? _stateForDay(
    DateTime day,
    Map<String, CalendarDayState> states,
  ) {
    return states[AppDateUtils.dateKey(day)];
  }

  Color _colorForState(CalendarDayState? state, BuildContext context) {
    switch (state) {
      case CalendarDayState.completed:
        return const Color(0xFF5E8B7E);
      case CalendarDayState.backfill:
        return const Color(0xFF7C9A92);
      case CalendarDayState.missed:
        return const Color(0xFF8A5D5D);
      case CalendarDayState.rest:
        return const Color(0xFF7D7A75);
      case CalendarDayState.duePending:
        return Theme.of(context).colorScheme.primary;
      case CalendarDayState.notDue:
      case null:
        return Colors.transparent;
    }
  }

  Widget _legend(BuildContext context, String label, CalendarDayState state) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: _colorForState(state, context),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }

  Widget _metricCard(BuildContext context, String title, String value) {
    return SizedBox(
      width: 150,
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spacingSm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(value, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(title, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetaRow(BuildContext context, String label, Widget value) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 96,
          child: Text(label, style: Theme.of(context).textTheme.bodySmall),
        ),
        Expanded(child: value),
      ],
    );
  }

  Widget _statusChip(ExperimentStatus status) {
    return Chip(
      label: Text(status.label),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _textSection(
    BuildContext context, {
    required String title,
    required String body,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSizes.spacingSm),
            Text(body),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmEndExperiment(
    BuildContext context,
    WidgetRef ref,
    String experimentId,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('End experiment'),
          content: const Text('Are you sure you want to end this experiment?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('End'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await ref
          .read(experimentActionControllerProvider.notifier)
          .end(experimentId);
    }
  }

  Future<void> _addSubtaskDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final created = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add subtask'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Subtask name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context).pop(controller.text.trim()),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (created == null || created.isEmpty) {
      return;
    }

    final updated = List<ExperimentSubtask>.from(experiment.subtasks)
      ..add(
        ExperimentSubtask(
          id: createId(),
          name: created,
          order: experiment.subtasks.length,
        ),
      );

    await _replaceSubtasks(ref, updated);
  }

  Future<void> _editSubtaskDialog(
    BuildContext context,
    WidgetRef ref,
    ExperimentSubtask target,
  ) async {
    final controller = TextEditingController(text: target.name);
    final edited = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit subtask'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Subtask name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context).pop(controller.text.trim()),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (edited == null || edited.isEmpty) {
      return;
    }

    final updated = experiment.subtasks.map((subtask) {
      if (subtask.id == target.id) {
        return subtask.copyWith(name: edited);
      }
      return subtask;
    }).toList();

    await _replaceSubtasks(ref, updated);
  }

  Future<void> _deleteSubtask(WidgetRef ref, String subtaskId) async {
    final updated = experiment.subtasks
        .where((subtask) => subtask.id != subtaskId)
        .toList();

    await _replaceSubtasks(ref, updated);
  }

  Future<void> _moveSubtask(WidgetRef ref, int from, int to) async {
    final updated = List<ExperimentSubtask>.from(experiment.subtasks);
    final item = updated.removeAt(from);
    updated.insert(to, item);

    await _replaceSubtasks(ref, updated);
  }

  Future<void> _replaceSubtasks(
    WidgetRef ref,
    List<ExperimentSubtask> subtasks,
  ) async {
    final normalized = List<ExperimentSubtask>.generate(subtasks.length, (
      index,
    ) {
      return subtasks[index].copyWith(order: index);
    });

    await ref
        .read(experimentActionControllerProvider.notifier)
        .replaceSubtasks(experiment.id, normalized);
  }

  DateTime _maxDate(DateTime a, DateTime b) {
    return a.isAfter(b) ? a : b;
  }
}
