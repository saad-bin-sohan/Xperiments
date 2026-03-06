import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/utils/date_utils.dart';
import 'package:mobile/core/widgets/app_async_view.dart';
import 'package:mobile/core/widgets/app_empty_state.dart';
import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/experiments/presentation/providers/experiments_providers.dart';
import 'package:mobile/features/history/presentation/providers/history_providers.dart';

class HistoryExperimentDetailScreen extends ConsumerStatefulWidget {
  const HistoryExperimentDetailScreen({super.key, required this.experimentId});

  final String experimentId;

  @override
  ConsumerState<HistoryExperimentDetailScreen> createState() {
    return _HistoryExperimentDetailScreenState();
  }
}

class _HistoryExperimentDetailScreenState
    extends ConsumerState<HistoryExperimentDetailScreen> {
  late final TextEditingController _reflectionController;
  late final TextEditingController _lessonsController;

  bool _seeded = false;
  bool _debriefSeeded = false;
  bool _savingReflection = false;
  bool _savingLessons = false;
  bool _savingDebrief = false;
  int? _regretScore;
  int? _surpriseScore;
  bool? _wouldRepeat;

  @override
  void initState() {
    super.initState();
    _reflectionController = TextEditingController();
    _lessonsController = TextEditingController();
  }

  @override
  void dispose() {
    _reflectionController.dispose();
    _lessonsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final experimentAsync = ref.watch(
      experimentByIdProvider(widget.experimentId),
    );

    return AppAsyncView<Experiment?>(
      value: experimentAsync,
      data: (experiment) {
        if (experiment == null) {
          return const Scaffold(
            body: AppEmptyState(
              title: 'Experiment not found',
              message: 'This history item is no longer available.',
            ),
          );
        }

        _seedControllers(experiment);

        return Scaffold(
          appBar: AppBar(title: Text(experiment.name)),
          body: ListView(
            padding: const EdgeInsets.all(AppSizes.spacingMd),
            children: <Widget>[
              if ((experiment.hypothesis ?? '').isNotEmpty ||
                  (experiment.finalReflection ?? '').isNotEmpty) ...[
                _hypothesisVsRealityCard(context, experiment),
                const SizedBox(height: AppSizes.spacingMd),
              ],
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.spacingMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _row('Status', experiment.status.label),
                      _row(
                        'Started',
                        AppDateUtils.formatDate(experiment.startDate),
                      ),
                      if (experiment.completedAt != null)
                        _row(
                          'Ended',
                          AppDateUtils.formatDate(experiment.completedAt!),
                        ),
                      if (experiment.passFailResult != null)
                        _row('Result', experiment.passFailResult!.label),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spacingMd),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.spacingMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Debrief',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSizes.spacingMd),
                      const Text(
                        'Regret score — how do you feel about doing this?',
                      ),
                      Row(
                        children: <Widget>[
                          const Text('Regret', style: TextStyle(fontSize: 12)),
                          Expanded(
                            child: Slider(
                              value: (_regretScore ?? 5).toDouble(),
                              min: 0,
                              max: 10,
                              divisions: 10,
                              label: (_regretScore ?? 5).toString(),
                              onChanged: (value) {
                                setState(() => _regretScore = value.round());
                              },
                            ),
                          ),
                          const Text(
                            'Zero regrets',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.spacingSm),
                      const Text(
                        'Surprise score — how close was reality to your hypothesis?',
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            'Expected',
                            style: TextStyle(fontSize: 12),
                          ),
                          Expanded(
                            child: Slider(
                              value: (_surpriseScore ?? 5).toDouble(),
                              min: 0,
                              max: 10,
                              divisions: 10,
                              label: (_surpriseScore ?? 5).toString(),
                              onChanged: (value) {
                                setState(() => _surpriseScore = value.round());
                              },
                            ),
                          ),
                          const Text(
                            'Surprised',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.spacingSm),
                      Row(
                        children: <Widget>[
                          const Expanded(
                            child: Text('Would you do this again?'),
                          ),
                          ToggleButtons(
                            isSelected: <bool>[
                              _wouldRepeat == true,
                              _wouldRepeat == false,
                            ],
                            onPressed: (index) {
                              setState(() => _wouldRepeat = index == 0);
                            },
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSizes.spacingMd,
                                ),
                                child: Text('Yes'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSizes.spacingMd,
                                ),
                                child: Text('No'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.spacingMd),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FilledButton(
                          onPressed: _savingDebrief ? null : _saveDebrief,
                          child: Text(
                            _savingDebrief ? 'Saving...' : 'Save Debrief',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spacingMd),
              _editorSection(
                context,
                title: 'Final Reflection',
                hint:
                    'Take a moment to reflect. What did you learn from this experiment?',
                controller: _reflectionController,
                saving: _savingReflection,
                onSave: _saveReflection,
              ),
              const SizedBox(height: AppSizes.spacingMd),
              _editorSection(
                context,
                title: 'Lessons Learned',
                hint: 'Capture the key takeaways you want to remember.',
                controller: _lessonsController,
                saving: _savingLessons,
                onSave: _saveLessons,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _hypothesisVsRealityCard(BuildContext context, Experiment experiment) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasHypothesis = (experiment.hypothesis ?? '').isNotEmpty;
    final hasOutcome = (experiment.finalReflection ?? '').isNotEmpty;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hypothesis vs. Reality',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSizes.spacingMd),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.spacingSm),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSizes.radiusMd),
                ),
                border: Border(
                  left: BorderSide(color: colorScheme.primary, width: 3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'YOUR HYPOTHESIS (BEFORE)',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingXs),
                  Text(
                    hasHypothesis
                        ? experiment.hypothesis!
                        : 'No hypothesis was set for this experiment.',
                    style: hasHypothesis
                        ? null
                        : TextStyle(
                            color: colorScheme.onSurface.withValues(alpha: 0.5),
                            fontStyle: FontStyle.italic,
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spacingSm),
            Center(
              child: Icon(
                Icons.arrow_downward_rounded,
                color: colorScheme.outline,
                size: 20,
              ),
            ),
            const SizedBox(height: AppSizes.spacingSm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.spacingSm),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSizes.radiusMd),
                ),
                border: Border(
                  left: BorderSide(color: colorScheme.tertiary, width: 3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'WHAT ACTUALLY HAPPENED (AFTER)',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colorScheme.tertiary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingXs),
                  Text(
                    hasOutcome
                        ? experiment.finalReflection!
                        : 'Fill in your reflection below to complete this picture.',
                    style: hasOutcome
                        ? null
                        : TextStyle(
                            color: colorScheme.onSurface.withValues(alpha: 0.5),
                            fontStyle: FontStyle.italic,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _editorSection(
    BuildContext context, {
    required String title,
    required String hint,
    required TextEditingController controller,
    required bool saving,
    required Future<void> Function() onSave,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSizes.spacingSm),
            TextField(
              controller: controller,
              minLines: 4,
              maxLines: 10,
              decoration: InputDecoration(hintText: hint),
            ),
            const SizedBox(height: AppSizes.spacingSm),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: saving ? null : onSave,
                child: Text(saving ? 'Saving...' : 'Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingXs),
      child: Row(
        children: <Widget>[
          SizedBox(width: 90, child: Text(label)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _seedControllers(Experiment experiment) {
    if (!_seeded) {
      _seeded = true;
      _reflectionController.text = experiment.finalReflection ?? '';
      _lessonsController.text = experiment.lessonsLearned ?? '';
    }

    if (!_debriefSeeded) {
      _debriefSeeded = true;
      _regretScore = experiment.regretScore;
      _surpriseScore = experiment.surpriseScore;
      _wouldRepeat = experiment.wouldRepeat;
    }
  }

  Future<void> _saveDebrief() async {
    setState(() => _savingDebrief = true);
    try {
      await ref
          .read(saveDebriefUseCaseProvider)
          .call(
            experimentId: widget.experimentId,
            regretScore: _regretScore,
            surpriseScore: _surpriseScore,
            wouldRepeat: _wouldRepeat,
          );
      ref.invalidate(experimentByIdProvider(widget.experimentId));
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Debrief saved.')));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) {
        setState(() => _savingDebrief = false);
      }
    }
  }

  Future<void> _saveReflection() async {
    setState(() => _savingReflection = true);
    try {
      await ref
          .read(saveFinalReflectionUseCaseProvider)
          .call(widget.experimentId, _reflectionController.text.trim());
      ref.invalidate(experimentByIdProvider(widget.experimentId));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Final reflection saved.')),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) {
        setState(() => _savingReflection = false);
      }
    }
  }

  Future<void> _saveLessons() async {
    setState(() => _savingLessons = true);
    try {
      await ref
          .read(saveLessonsLearnedUseCaseProvider)
          .call(widget.experimentId, _lessonsController.text.trim());
      ref.invalidate(experimentByIdProvider(widget.experimentId));
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Lessons learned saved.')));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) {
        setState(() => _savingLessons = false);
      }
    }
  }
}
