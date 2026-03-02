import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/experiments/domain/entities/experiment.dart';

class ExperimentModel {
  const ExperimentModel({
    required this.id,
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
    this.endDate,
    required this.status,
    this.passFailResult,
    this.pausedAt,
    required this.remindersEnabled,
    this.reminderTime,
    this.interferenceNote,
    required this.interferenceLogEnabled,
    required this.createdAt,
    this.completedAt,
    this.finalReflection,
    this.lessonsLearned,
    required this.subtasks,
    required this.pauseHistory,
  });

  final String id;
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
  final DateTime? endDate;
  final ExperimentStatus status;
  final PassFailResult? passFailResult;
  final DateTime? pausedAt;
  final bool remindersEnabled;
  final String? reminderTime;
  final String? interferenceNote;
  final bool interferenceLogEnabled;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? finalReflection;
  final String? lessonsLearned;
  final List<ExperimentSubtask> subtasks;
  final List<PauseWindow> pauseHistory;

  factory ExperimentModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};

    return ExperimentModel(
      id: doc.id,
      userId: data['userId'] as String? ?? '',
      labId: data['labId'] as String? ?? '',
      name: data['name'] as String? ?? '',
      hypothesis: data['hypothesis'] as String?,
      motivation: data['motivation'] as String?,
      startDate: _readDate(data['startDate']) ?? DateTime.now(),
      frequency: ExperimentFrequency.fromValue(data['frequency'] as String?),
      customDays: _readCustomDays(data['customDays']),
      isOpenEnded: data['isOpenEnded'] as bool? ?? false,
      durationValue: (data['durationValue'] as num?)?.toInt(),
      durationUnit: data['durationUnit'] == null
          ? null
          : ExperimentDurationUnit.fromValue(data['durationUnit'] as String?),
      endDate: _readDate(data['endDate']),
      status: ExperimentStatus.fromValue(data['status'] as String?),
      passFailResult: PassFailResult.fromValue(
        data['passFailResult'] as String?,
      ),
      pausedAt: _readDate(data['pausedAt']),
      remindersEnabled: data['remindersEnabled'] as bool? ?? false,
      reminderTime: data['reminderTime'] as String?,
      interferenceNote: data['interferenceNote'] as String?,
      interferenceLogEnabled: data['interferenceLogEnabled'] as bool? ?? false,
      createdAt: _readDate(data['createdAt']) ?? DateTime.now(),
      completedAt: _readDate(data['completedAt']),
      finalReflection: data['finalReflection'] as String?,
      lessonsLearned: data['lessonsLearned'] as String?,
      subtasks: _readSubtasks(data['subtasks']),
      pauseHistory: _readPauseHistory(data['pauseHistory']),
    );
  }

  static DateTime? _readDate(Object? raw) {
    if (raw == null) {
      return null;
    }
    if (raw is Timestamp) {
      return raw.toDate();
    }
    if (raw is DateTime) {
      return raw;
    }
    return null;
  }

  static List<int>? _readCustomDays(Object? raw) {
    if (raw is! List) {
      return null;
    }

    final parsed = raw.map((value) => (value as num).toInt()).toList();
    if (parsed.isEmpty) {
      return null;
    }
    return parsed;
  }

  static List<ExperimentSubtask> _readSubtasks(Object? raw) {
    if (raw is! List) {
      return const <ExperimentSubtask>[];
    }

    return raw.whereType<Map<String, dynamic>>().map((item) {
      return ExperimentSubtask(
        id: item['id'] as String? ?? '',
        name: item['name'] as String? ?? '',
        order: (item['order'] as num?)?.toInt() ?? 0,
      );
    }).toList()..sort((a, b) => a.order.compareTo(b.order));
  }

  static List<PauseWindow> _readPauseHistory(Object? raw) {
    if (raw is! List) {
      return const <PauseWindow>[];
    }

    return raw.whereType<Map<String, dynamic>>().map((item) {
      final pausedAt = _readDate(item['pausedAt']) ?? DateTime.now();
      final resumedAt = _readDate(item['resumedAt']) ?? pausedAt;
      return PauseWindow(pausedAt: pausedAt, resumedAt: resumedAt);
    }).toList();
  }
}

extension ExperimentModelX on ExperimentModel {
  Experiment toEntity() {
    return Experiment(
      id: id,
      userId: userId,
      labId: labId,
      name: name,
      hypothesis: hypothesis,
      motivation: motivation,
      startDate: startDate,
      frequency: frequency,
      customDays: customDays,
      isOpenEnded: isOpenEnded,
      durationValue: durationValue,
      durationUnit: durationUnit,
      endDate: endDate,
      status: status,
      passFailResult: passFailResult,
      pausedAt: pausedAt,
      remindersEnabled: remindersEnabled,
      reminderTime: reminderTime,
      interferenceNote: interferenceNote,
      interferenceLogEnabled: interferenceLogEnabled,
      createdAt: createdAt,
      completedAt: completedAt,
      finalReflection: finalReflection,
      lessonsLearned: lessonsLearned,
      subtasks: subtasks,
      pauseHistory: pauseHistory,
    );
  }
}
