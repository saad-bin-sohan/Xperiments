import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/routing/route_paths.dart';
import 'package:mobile/core/utils/date_utils.dart';
import 'package:mobile/core/widgets/app_async_view.dart';
import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/experiments/domain/entities/experiment_draft.dart';
import 'package:mobile/features/experiments/presentation/controllers/experiment_form_controller.dart';
import 'package:mobile/features/experiments/presentation/models/experiment_form_prefill.dart';
import 'package:mobile/features/experiments/presentation/providers/experiments_providers.dart';
import 'package:mobile/features/labs/domain/entities/lab.dart';
import 'package:mobile/features/labs/presentation/providers/labs_providers.dart';
import 'package:mobile/features/profile/presentation/providers/profile_providers.dart';
import 'package:uuid/uuid.dart';

class ExperimentFormScreen extends ConsumerStatefulWidget {
  const ExperimentFormScreen({super.key, this.initialLabId, this.prefill});

  final String? initialLabId;
  final ExperimentFormPrefill? prefill;

  @override
  ConsumerState<ExperimentFormScreen> createState() =>
      _ExperimentFormScreenState();
}

class _ExperimentFormScreenState extends ConsumerState<ExperimentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  late final TextEditingController _nameController;
  late final TextEditingController _hypothesisController;
  late final TextEditingController _motivationController;
  late final TextEditingController _durationController;
  late final TextEditingController _interferenceController;

  final List<TextEditingController> _subtaskControllers =
      <TextEditingController>[];

  String? _selectedLabId;
  DateTime _startDate = AppDateUtils.startOfDay(DateTime.now());
  ExperimentFrequency _frequency = ExperimentFrequency.daily;
  final Set<int> _customDays = <int>{};
  bool _isOpenEnded = false;
  ExperimentDurationUnit _durationUnit = ExperimentDurationUnit.days;
  bool _remindersEnabled = false;
  TimeOfDay? _reminderTime;
  bool _interferenceEnabled = false;
  bool _interferenceInitialized = false;

  static const _weekdays = <String>[
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.prefill?.name ?? '');
    _hypothesisController = TextEditingController(
      text: widget.prefill?.hypothesis ?? '',
    );
    _motivationController = TextEditingController();
    _durationController = TextEditingController(
      text: widget.prefill?.durationValue?.toString() ?? '30',
    );
    _interferenceController = TextEditingController();
    _selectedLabId = widget.initialLabId;

    if (widget.prefill != null) {
      _frequency = widget.prefill!.frequency;
      _isOpenEnded = widget.prefill!.isOpenEnded;
      if (widget.prefill!.durationUnit != null) {
        _durationUnit = widget.prefill!.durationUnit!;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _hypothesisController.dispose();
    _motivationController.dispose();
    _durationController.dispose();
    _interferenceController.dispose();
    for (final controller in _subtaskControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(experimentFormControllerProvider, (_, next) {
      next.whenOrNull(
        error: (Object error, StackTrace _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    final labsAsync = ref.watch(currentUserLabsProvider);
    final activeCountAsync = ref.watch(activeExperimentsCountProvider);
    final prefsAsync = ref.watch(currentUserPreferencesProvider);
    final isBusy = ref.watch(experimentFormControllerProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.prefill == null ? 'New Experiment' : 'Start from Template',
        ),
      ),
      body: AppAsyncView<List<Lab>>(
        value: labsAsync,
        data: (labs) {
          final activeCount = activeCountAsync.asData?.value ?? 0;
          final preferences = prefsAsync.asData?.value;

          if (!_interferenceInitialized && preferences != null) {
            _interferenceEnabled =
                preferences.interferenceLogEnabled && activeCount > 0;
            _interferenceInitialized = true;
          }

          if (_selectedLabId == null && labs.isNotEmpty) {
            _selectedLabId = labs.first.id;
          }

          return ListView(
            padding: const EdgeInsets.all(AppSizes.spacingMd),
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _sectionTitle(context, 'Basics'),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Experiment name',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Experiment name is required.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSizes.spacingSm),
                    TextFormField(
                      controller: _hypothesisController,
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Hypothesis (optional)',
                        hintText: 'What do you expect to happen?',
                      ),
                    ),
                    const SizedBox(height: AppSizes.spacingSm),
                    TextFormField(
                      controller: _motivationController,
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Motivation / Inspiration (optional)',
                        hintText: 'Why are you doing this?',
                      ),
                    ),
                    const SizedBox(height: AppSizes.spacingSm),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedLabId,
                      decoration: const InputDecoration(labelText: 'Lab'),
                      items: labs
                          .map(
                            (lab) => DropdownMenuItem<String>(
                              value: lab.id,
                              child: Text(lab.name),
                            ),
                          )
                          .toList(),
                      onChanged: isBusy
                          ? null
                          : (value) {
                              setState(() => _selectedLabId = value);
                            },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lab is required.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSizes.spacingLg),
                    _sectionTitle(context, 'Schedule'),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Start date'),
                      subtitle: Text(AppDateUtils.formatDate(_startDate)),
                      trailing: const Icon(Icons.calendar_today_outlined),
                      onTap: isBusy ? null : () => _pickStartDate(context),
                    ),
                    const SizedBox(height: AppSizes.spacingSm),
                    SegmentedButton<ExperimentFrequency>(
                      selected: <ExperimentFrequency>{_frequency},
                      segments: const <ButtonSegment<ExperimentFrequency>>[
                        ButtonSegment(
                          value: ExperimentFrequency.daily,
                          label: Text('Daily'),
                        ),
                        ButtonSegment(
                          value: ExperimentFrequency.weekly,
                          label: Text('Weekly'),
                        ),
                        ButtonSegment(
                          value: ExperimentFrequency.custom,
                          label: Text('Custom'),
                        ),
                      ],
                      onSelectionChanged: isBusy
                          ? null
                          : (selection) {
                              setState(() {
                                _frequency = selection.first;
                                if (_frequency != ExperimentFrequency.custom) {
                                  _customDays.clear();
                                }
                              });
                            },
                    ),
                    if (_frequency == ExperimentFrequency.custom) ...<Widget>[
                      const SizedBox(height: AppSizes.spacingSm),
                      Wrap(
                        spacing: AppSizes.spacingXs,
                        children: List.generate(_weekdays.length, (index) {
                          return FilterChip(
                            label: Text(_weekdays[index]),
                            selected: _customDays.contains(index),
                            onSelected: isBusy
                                ? null
                                : (selected) {
                                    setState(() {
                                      if (selected) {
                                        _customDays.add(index);
                                      } else {
                                        _customDays.remove(index);
                                      }
                                    });
                                  },
                          );
                        }),
                      ),
                    ],
                    const SizedBox(height: AppSizes.spacingLg),
                    _sectionTitle(context, 'Duration'),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      value: _isOpenEnded,
                      title: const Text('Open-ended'),
                      onChanged: isBusy
                          ? null
                          : (value) {
                              setState(() => _isOpenEnded = value);
                            },
                    ),
                    if (!_isOpenEnded) ...<Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _durationController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Duration value',
                              ),
                              validator: (value) {
                                if (_isOpenEnded) {
                                  return null;
                                }
                                final parsed = int.tryParse(value ?? '');
                                if (parsed == null || parsed <= 0) {
                                  return 'Enter a valid duration.';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: AppSizes.spacingSm),
                          Expanded(
                            child:
                                DropdownButtonFormField<ExperimentDurationUnit>(
                                  initialValue: _durationUnit,
                                  decoration: const InputDecoration(
                                    labelText: 'Unit',
                                  ),
                                  items: ExperimentDurationUnit.values
                                      .map(
                                        (unit) => DropdownMenuItem(
                                          value: unit,
                                          child: Text(unit.label),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: isBusy
                                      ? null
                                      : (value) {
                                          if (value != null) {
                                            setState(
                                              () => _durationUnit = value,
                                            );
                                          }
                                        },
                                ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: AppSizes.spacingLg),
                    _sectionTitle(context, 'Reminder'),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      value: _remindersEnabled,
                      title: const Text('Enable reminder'),
                      onChanged: isBusy
                          ? null
                          : (value) {
                              setState(() => _remindersEnabled = value);
                            },
                    ),
                    if (_remindersEnabled)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Reminder time'),
                        subtitle: Text(
                          _reminderTime == null
                              ? 'Select time'
                              : _reminderTime!.format(context),
                        ),
                        trailing: const Icon(Icons.access_time),
                        onTap: isBusy ? null : () => _pickReminderTime(context),
                      ),
                    const SizedBox(height: AppSizes.spacingLg),
                    _sectionTitle(context, 'Subtasks'),
                    ..._buildSubtaskInputs(context, isBusy),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: isBusy ? null : _addSubtask,
                        icon: const Icon(Icons.add),
                        label: const Text('Add subtask'),
                      ),
                    ),
                    if (activeCount > 0) ...<Widget>[
                      const SizedBox(height: AppSizes.spacingLg),
                      _sectionTitle(context, 'Interference Log'),
                      Text(
                        'You have $activeCount active experiment(s). Would you like to note potential interference?',
                      ),
                      const SizedBox(height: AppSizes.spacingSm),
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        value: _interferenceEnabled,
                        title: const Text('Enable interference note'),
                        onChanged: isBusy
                            ? null
                            : (value) {
                                setState(() => _interferenceEnabled = value);
                              },
                      ),
                      if (_interferenceEnabled)
                        TextFormField(
                          controller: _interferenceController,
                          minLines: 2,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: 'Interference note',
                            hintText:
                                'Note any experiments that might confound each other, and how.',
                          ),
                        ),
                    ],
                    const SizedBox(height: AppSizes.spacingXl),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: isBusy ? null : _submit,
                        child: const Text('Create Experiment'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildSubtaskInputs(BuildContext context, bool isBusy) {
    if (_subtaskControllers.isEmpty) {
      return const <Widget>[Text('No subtasks added yet.')];
    }

    return List<Widget>.generate(_subtaskControllers.length, (index) {
      final controller = _subtaskControllers[index];
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.spacingSm),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(labelText: 'Subtask ${index + 1}'),
              ),
            ),
            IconButton(
              onPressed: isBusy
                  ? null
                  : () {
                      setState(() {
                        final removed = _subtaskControllers.removeAt(index);
                        removed.dispose();
                      });
                    },
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      );
    });
  }

  Future<void> _pickStartDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      setState(() => _startDate = AppDateUtils.startOfDay(selected));
    }
  }

  Future<void> _pickReminderTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: _reminderTime ?? TimeOfDay.now(),
    );

    if (selected != null) {
      setState(() => _reminderTime = selected);
    }
  }

  void _addSubtask() {
    setState(() {
      _subtaskControllers.add(TextEditingController());
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedLabId == null || _selectedLabId!.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a lab.')));
      return;
    }

    if (_frequency == ExperimentFrequency.custom && _customDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select at least one custom day.')),
      );
      return;
    }

    if (_remindersEnabled && _reminderTime == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Select a reminder time.')));
      return;
    }

    final session = ref.read(authSessionProvider).asData?.value;
    final user = session?.user;
    if (user == null) {
      return;
    }

    final subtasks = _subtaskControllers
        .map((controller) => controller.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    final draft = ExperimentDraft(
      userId: user.id,
      labId: _selectedLabId!,
      name: _nameController.text.trim(),
      hypothesis: _hypothesisController.text.trim().isEmpty
          ? null
          : _hypothesisController.text.trim(),
      motivation: _motivationController.text.trim().isEmpty
          ? null
          : _motivationController.text.trim(),
      startDate: _startDate,
      frequency: _frequency,
      customDays: _frequency == ExperimentFrequency.custom
          ? (_customDays.toList()..sort())
          : null,
      isOpenEnded: _isOpenEnded,
      durationValue: _isOpenEnded
          ? null
          : int.tryParse(_durationController.text),
      durationUnit: _isOpenEnded ? null : _durationUnit,
      remindersEnabled: _remindersEnabled,
      reminderTime: _remindersEnabled && _reminderTime != null
          ? '${_reminderTime!.hour.toString().padLeft(2, '0')}:${_reminderTime!.minute.toString().padLeft(2, '0')}'
          : null,
      interferenceLogEnabled: _interferenceEnabled,
      interferenceNote:
          _interferenceEnabled && _interferenceController.text.trim().isNotEmpty
          ? _interferenceController.text.trim()
          : null,
      subtasks: List<ExperimentSubtask>.generate(subtasks.length, (index) {
        return ExperimentSubtask(
          id: _uuid.v4(),
          name: subtasks[index],
          order: index,
        );
      }),
    );

    final experimentId = await ref
        .read(experimentFormControllerProvider.notifier)
        .createExperiment(draft);

    if (!mounted || experimentId == null) {
      return;
    }

    context.go(RoutePaths.experimentDetail(experimentId));
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingSm),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
