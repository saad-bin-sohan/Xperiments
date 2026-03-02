import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/utils/date_utils.dart';
import 'package:mobile/core/widgets/app_async_view.dart';
import 'package:mobile/core/widgets/app_empty_state.dart';
import 'package:mobile/features/checkin/domain/entities/checkin_draft.dart';
import 'package:mobile/features/checkin/domain/entities/checkin_record.dart';
import 'package:mobile/features/checkin/presentation/controllers/checkin_flow_controller.dart';
import 'package:mobile/features/checkin/presentation/providers/checkin_providers.dart';
import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/experiments/presentation/providers/experiments_providers.dart';

class CheckinScreen extends ConsumerStatefulWidget {
  const CheckinScreen({
    super.key,
    required this.experimentId,
    required this.date,
  });

  final String experimentId;
  final DateTime date;

  @override
  ConsumerState<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends ConsumerState<CheckinScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _moodController = TextEditingController();
  final TextEditingController _journalController = TextEditingController();

  int _stepIndex = 0;
  bool _optimisticCompleted = true;
  int? _rating;
  String? _photoPath;
  String? _existingPhotoUrl;
  bool _initializedFromExisting = false;
  Map<String, bool> _subtaskCompletions = <String, bool>{};

  static const List<String> _stepTitles = <String>[
    'Confirm',
    'Mood',
    'Sub-tasks',
    'Rating',
    'Photo',
    'Journal',
    'Save',
  ];

  @override
  void dispose() {
    _moodController.dispose();
    _journalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(checkinFlowControllerProvider, (_, next) {
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
    final existingCheckinAsync = ref.watch(
      checkinForDateProvider(
        CheckinLookupArgs(experimentId: widget.experimentId, date: widget.date),
      ),
    );

    return AppAsyncView<Experiment?>(
      value: experimentAsync,
      data: (experiment) {
        if (experiment == null) {
          return const Scaffold(
            body: AppEmptyState(
              title: 'Experiment not found',
              message: 'This experiment may have been removed.',
            ),
          );
        }

        return AppAsyncView<CheckinRecord?>(
          value: existingCheckinAsync,
          data: (existing) {
            _seedFromExistingOnce(existing);
            return _buildScaffold(context, experiment, existing);
          },
        );
      },
    );
  }

  Scaffold _buildScaffold(
    BuildContext context,
    Experiment experiment,
    CheckinRecord? existing,
  ) {
    final isBusy = ref.watch(checkinFlowControllerProvider).isLoading;
    final isBackfill = widget.date.isBefore(
      AppDateUtils.startOfDay(DateTime.now()),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Check-in • ${AppDateUtils.formatDate(widget.date)}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        children: <Widget>[
          _progressHeader(context, isBackfill: isBackfill),
          const SizedBox(height: AppSizes.spacingMd),
          _stepCard(context, experiment, existing),
          const SizedBox(height: AppSizes.spacingMd),
          Row(
            children: <Widget>[
              if (_stepIndex > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: isBusy
                        ? null
                        : () {
                            setState(() => _stepIndex -= 1);
                          },
                    child: const Text('Back'),
                  ),
                ),
              if (_stepIndex > 0) const SizedBox(width: AppSizes.spacingSm),
              Expanded(
                child: FilledButton(
                  onPressed: isBusy
                      ? null
                      : () {
                          if (_stepIndex < _stepTitles.length - 1) {
                            setState(() => _stepIndex += 1);
                          } else {
                            _saveCheckin();
                          }
                        },
                  child: Text(
                    _stepIndex == _stepTitles.length - 1 ? 'Save' : 'Next',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spacingSm),
          OutlinedButton.icon(
            onPressed: isBusy ? null : _markRestDay,
            icon: const Icon(Icons.hotel_outlined),
            label: const Text('Mark as rest day'),
          ),
        ],
      ),
    );
  }

  Widget _progressHeader(BuildContext context, {required bool isBackfill}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Step ${_stepIndex + 1} of ${_stepTitles.length}'),
            const SizedBox(height: AppSizes.spacingXs),
            Text(
              _stepTitles[_stepIndex],
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (isBackfill)
              const Padding(
                padding: EdgeInsets.only(top: AppSizes.spacingXs),
                child: Text('Backfill entry'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _stepCard(
    BuildContext context,
    Experiment experiment,
    CheckinRecord? existing,
  ) {
    switch (_stepIndex) {
      case 0:
        return _confirmStep(context, existing);
      case 1:
        return _moodStep();
      case 2:
        return _subtasksStep(experiment);
      case 3:
        return _ratingStep();
      case 4:
        return _photoStep(context);
      case 5:
        return _journalStep();
      case 6:
        return _saveStep(context, experiment);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _confirmStep(BuildContext context, CheckinRecord? existing) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _optimisticCompleted
                  ? 'This day is marked completed.'
                  : 'Tap to mark this day completed.',
            ),
            const SizedBox(height: AppSizes.spacingSm),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: const Text('Completed'),
              value: _optimisticCompleted,
              onChanged: (value) {
                setState(() => _optimisticCompleted = value);
              },
            ),
            if (existing != null)
              const Padding(
                padding: EdgeInsets.only(top: AppSizes.spacingXs),
                child: Text(
                  'Existing check-in found for this date. Saving will update it.',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _moodStep() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: TextField(
          controller: _moodController,
          decoration: const InputDecoration(
            labelText: 'How are you feeling? (optional)',
            hintText: 'focused, tired, energized, calm…',
          ),
        ),
      ),
    );
  }

  Widget _subtasksStep(Experiment experiment) {
    if (experiment.subtasks.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.spacingMd),
          child: Text('No sub-tasks for this experiment.'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Sub-tasks'),
            const SizedBox(height: AppSizes.spacingSm),
            ...experiment.subtasks.map((subtask) {
              final checked = _subtaskCompletions[subtask.id] ?? false;
              return CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: checked,
                title: Text(subtask.name),
                onChanged: (value) {
                  setState(() {
                    _subtaskCompletions[subtask.id] = value ?? false;
                  });
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _ratingStep() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Rating (optional)'),
            const SizedBox(height: AppSizes.spacingSm),
            Wrap(
              spacing: AppSizes.spacingXs,
              children: List<Widget>.generate(5, (index) {
                final value = index + 1;
                return ChoiceChip(
                  label: Text('$value'),
                  selected: _rating == value,
                  onSelected: (selected) {
                    setState(() {
                      _rating = selected ? value : null;
                    });
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _photoStep(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Photo (optional)'),
            const SizedBox(height: AppSizes.spacingSm),
            Row(
              children: <Widget>[
                FilledButton.tonalIcon(
                  onPressed: () => _pickPhoto(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: const Text('Camera'),
                ),
                const SizedBox(width: AppSizes.spacingSm),
                FilledButton.tonalIcon(
                  onPressed: () => _pickPhoto(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library_outlined),
                  label: const Text('Gallery'),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spacingSm),
            if (_photoPath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(_photoPath!),
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else if (_existingPhotoUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  _existingPhotoUrl!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              const Text('No photo selected.'),
            if (_photoPath != null || _existingPhotoUrl != null)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _photoPath = null;
                      _existingPhotoUrl = null;
                    });
                  },
                  child: const Text('Remove photo'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _journalStep() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: TextField(
          controller: _journalController,
          minLines: 4,
          maxLines: 8,
          decoration: const InputDecoration(
            labelText: 'Any notes for today? (optional)',
          ),
        ),
      ),
    );
  }

  Widget _saveStep(BuildContext context, Experiment experiment) {
    final isBackfill = widget.date.isBefore(
      AppDateUtils.startOfDay(DateTime.now()),
    );
    final checkedCount = _subtaskCompletions.values
        .where((done) => done)
        .length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Ready to save',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSizes.spacingSm),
            _summaryRow('Experiment', experiment.name),
            _summaryRow('Date', AppDateUtils.formatDate(widget.date)),
            _summaryRow('Completed', _optimisticCompleted ? 'Yes' : 'No'),
            _summaryRow('Backfill', isBackfill ? 'Yes' : 'No'),
            _summaryRow(
              'Mood',
              _moodController.text.trim().isEmpty
                  ? 'None'
                  : _moodController.text.trim(),
            ),
            _summaryRow(
              'Sub-tasks done',
              '$checkedCount/${experiment.subtasks.length}',
            ),
            _summaryRow('Rating', _rating?.toString() ?? 'None'),
            _summaryRow(
              'Photo',
              _photoPath != null || _existingPhotoUrl != null
                  ? 'Attached'
                  : 'None',
            ),
            _summaryRow(
              'Journal',
              _journalController.text.trim().isEmpty ? 'None' : 'Added',
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingXs),
      child: Row(
        children: <Widget>[
          SizedBox(width: 112, child: Text(label)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Future<void> _pickPhoto(ImageSource source) async {
    final file = await _imagePicker.pickImage(
      source: source,
      maxWidth: 2200,
      maxHeight: 2200,
      imageQuality: 95,
    );

    if (file == null) {
      return;
    }

    setState(() {
      _photoPath = file.path;
      _existingPhotoUrl = null;
    });
  }

  Future<void> _saveCheckin() async {
    final draft = CheckinDraft(
      experimentId: widget.experimentId,
      date: widget.date,
      moodWords: _moodController.text.trim().isEmpty
          ? null
          : _moodController.text.trim(),
      subtaskCompletions: _subtaskCompletions,
      rating: _rating,
      photoFilePath: _photoPath,
      journalEntry: _journalController.text.trim().isEmpty
          ? null
          : _journalController.text.trim(),
      isBackfill: widget.date.isBefore(AppDateUtils.startOfDay(DateTime.now())),
      isRestDay: !_optimisticCompleted,
    );

    final saved = await ref
        .read(checkinFlowControllerProvider.notifier)
        .save(draft);

    if (saved == null || !mounted) {
      return;
    }

    context.pop();
  }

  Future<void> _markRestDay() async {
    await ref
        .read(checkinFlowControllerProvider.notifier)
        .markRestDay(widget.experimentId, widget.date);

    if (!mounted) {
      return;
    }

    context.pop();
  }

  void _seedFromExistingOnce(CheckinRecord? existing) {
    if (_initializedFromExisting || existing == null) {
      return;
    }

    _initializedFromExisting = true;
    _moodController.text = existing.moodWords ?? '';
    _journalController.text = existing.journalEntry ?? '';
    _subtaskCompletions = Map<String, bool>.from(existing.subtaskCompletions);
    _rating = existing.rating;
    _existingPhotoUrl = existing.photoUrl;
    _optimisticCompleted = existing.completed && !existing.isRestDay;
  }
}
