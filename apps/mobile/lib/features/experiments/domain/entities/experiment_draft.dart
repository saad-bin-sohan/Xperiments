import 'package:mobile/features/experiments/domain/entities/experiment.dart';

class ExperimentDraft {
  const ExperimentDraft({
    required this.userId,
    required this.labId,
    required this.name,
    this.hypothesis,
    this.motivation,
    required this.startDate,
    required this.frequency,
    this.customDays,
    required this.isOpenEnded,
    this.durationValue,
    this.durationUnit,
    this.remindersEnabled = false,
    this.reminderTime,
    this.interferenceNote,
    this.interferenceLogEnabled = false,
    this.subtasks = const <ExperimentSubtask>[],
  });

  final String userId;
  final String labId;
  final String name;
  final String? hypothesis;
  final String? motivation;
  final DateTime startDate;
  final ExperimentFrequency frequency;
  final List<int>? customDays;
  final bool isOpenEnded;
  final int? durationValue;
  final ExperimentDurationUnit? durationUnit;
  final bool remindersEnabled;
  final String? reminderTime;
  final String? interferenceNote;
  final bool interferenceLogEnabled;
  final List<ExperimentSubtask> subtasks;
}
