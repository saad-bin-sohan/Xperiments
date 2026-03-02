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
  bool _savingReflection = false;
  bool _savingLessons = false;

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
    if (_seeded) {
      return;
    }

    _seeded = true;
    _reflectionController.text = experiment.finalReflection ?? '';
    _lessonsController.text = experiment.lessonsLearned ?? '';
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
