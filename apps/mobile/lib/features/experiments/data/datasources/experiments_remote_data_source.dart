import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/core/constants/firebase_collections.dart';
import 'package:mobile/core/utils/date_utils.dart';
import 'package:mobile/features/experiments/data/models/experiment_model.dart';
import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/experiments/domain/entities/experiment_analytics.dart';
import 'package:mobile/features/experiments/domain/entities/experiment_draft.dart';
import 'package:mobile/features/experiments/domain/entities/today_due_item.dart';

class ExperimentsRemoteDataSource {
  const ExperimentsRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _experimentsCollection {
    return _firestore.collection(FirebaseCollections.experiments);
  }

  CollectionReference<Map<String, dynamic>> get _labsCollection {
    return _firestore.collection(FirebaseCollections.labs);
  }

  Future<String> createExperiment(ExperimentDraft draft) async {
    final startDate = AppDateUtils.startOfDay(draft.startDate);
    final endDate = _calculateInitialEndDate(draft);

    final doc = await _experimentsCollection.add(<String, dynamic>{
      'userId': draft.userId,
      'labId': draft.labId,
      'name': draft.name,
      'hypothesis': _nullable(draft.hypothesis),
      'motivation': _nullable(draft.motivation),
      'startDate': startDate,
      'frequency': draft.frequency.value,
      'customDays': draft.customDays,
      'isOpenEnded': draft.isOpenEnded,
      'durationValue': draft.durationValue,
      'durationUnit': draft.durationUnit?.value,
      'endDate': endDate,
      'status': ExperimentStatus.active.value,
      'passFailResult': null,
      'pausedAt': null,
      'remindersEnabled': draft.remindersEnabled,
      'reminderTime': draft.reminderTime,
      'interferenceNote': _nullable(draft.interferenceNote),
      'interferenceLogEnabled': draft.interferenceLogEnabled,
      'createdAt': FieldValue.serverTimestamp(),
      'completedAt': null,
      'finalReflection': null,
      'lessonsLearned': null,
      'subtasks': _serializeSubtasks(draft.subtasks),
      'pauseHistory': const <Map<String, dynamic>>[],
    });

    return doc.id;
  }

  Future<void> updateExperiment({
    required String experimentId,
    required ExperimentDraft draft,
  }) async {
    final startDate = AppDateUtils.startOfDay(draft.startDate);
    final endDate = _calculateInitialEndDate(draft);

    await _experimentsCollection.doc(experimentId).set(<String, dynamic>{
      'userId': draft.userId,
      'labId': draft.labId,
      'name': draft.name,
      'hypothesis': _nullable(draft.hypothesis),
      'motivation': _nullable(draft.motivation),
      'startDate': startDate,
      'frequency': draft.frequency.value,
      'customDays': draft.customDays,
      'isOpenEnded': draft.isOpenEnded,
      'durationValue': draft.durationValue,
      'durationUnit': draft.durationUnit?.value,
      'endDate': endDate,
      'remindersEnabled': draft.remindersEnabled,
      'reminderTime': draft.reminderTime,
      'interferenceNote': _nullable(draft.interferenceNote),
      'interferenceLogEnabled': draft.interferenceLogEnabled,
      'subtasks': _serializeSubtasks(draft.subtasks),
    }, SetOptions(merge: true));
  }

  Stream<List<ExperimentModel>> watchLabExperiments({
    required String labId,
    required String userId,
  }) {
    return _experimentsCollection
        .where('userId', isEqualTo: userId)
        .where('labId', isEqualTo: labId)
        .where(
          'status',
          whereIn: <String>[
            ExperimentStatus.active.value,
            ExperimentStatus.paused.value,
          ],
        )
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((
            QueryDocumentSnapshot<Map<String, dynamic>> doc,
          ) {
            return ExperimentModel.fromDoc(doc);
          }).toList();
        });
  }

  Stream<ExperimentModel?> watchExperimentById(String experimentId) {
    return _experimentsCollection.doc(experimentId).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return null;
      }
      return ExperimentModel.fromDoc(snapshot);
    });
  }

  Future<void> pauseExperiment(String experimentId, DateTime now) async {
    final snapshot = await _experimentsCollection.doc(experimentId).get();
    if (!snapshot.exists) {
      return;
    }

    final model = ExperimentModel.fromDoc(snapshot);
    if (model.status != ExperimentStatus.active) {
      return;
    }

    await snapshot.reference.update(<String, dynamic>{
      'status': ExperimentStatus.paused.value,
      'pausedAt': now,
    });
  }

  Future<void> resumeExperiment(String experimentId, DateTime now) async {
    final snapshot = await _experimentsCollection.doc(experimentId).get();
    if (!snapshot.exists) {
      return;
    }

    final model = ExperimentModel.fromDoc(snapshot);
    if (model.status != ExperimentStatus.paused || model.pausedAt == null) {
      return;
    }

    final pausedAt = model.pausedAt!;
    final pausedDays = max(
      0,
      AppDateUtils.startOfDay(
        now,
      ).difference(AppDateUtils.startOfDay(pausedAt)).inDays,
    );

    DateTime? newEndDate = model.endDate;
    if (!model.isOpenEnded && model.endDate != null && pausedDays > 0) {
      newEndDate = model.endDate!.add(Duration(days: pausedDays));
    }

    final history = List<PauseWindow>.from(model.pauseHistory)
      ..add(PauseWindow(pausedAt: pausedAt, resumedAt: now));

    await snapshot.reference.update(<String, dynamic>{
      'status': ExperimentStatus.active.value,
      'pausedAt': null,
      'pauseHistory': _serializePauseHistory(history),
      'endDate': newEndDate,
    });
  }

  Future<void> endExperiment(String experimentId, DateTime now) async {
    await endExperimentWithOptionalReflection(
      experimentId: experimentId,
      now: now,
      finalReflection: null,
    );
  }

  Future<void> endExperimentWithOptionalReflection({
    required String experimentId,
    required DateTime now,
    String? finalReflection,
  }) async {
    final snapshot = await _experimentsCollection.doc(experimentId).get();
    if (!snapshot.exists) {
      return;
    }

    final model = ExperimentModel.fromDoc(snapshot);
    if (model.status == ExperimentStatus.completed ||
        model.status == ExperimentStatus.endedEarly) {
      return;
    }

    final history = List<PauseWindow>.from(model.pauseHistory);
    if (model.status == ExperimentStatus.paused && model.pausedAt != null) {
      history.add(PauseWindow(pausedAt: model.pausedAt!, resumedAt: now));
    }

    final nowDay = AppDateUtils.startOfDay(now);
    final endDay = model.endDate == null
        ? null
        : AppDateUtils.startOfDay(model.endDate!);

    final newStatus = model.isOpenEnded
        ? ExperimentStatus.completed
        : (endDay != null && nowDay.isBefore(endDay)
              ? ExperimentStatus.endedEarly
              : ExperimentStatus.completed);

    await snapshot.reference.update(<String, dynamic>{
      'status': newStatus.value,
      'completedAt': now,
      'pausedAt': null,
      'finalReflection': _nullable(finalReflection),
      'pauseHistory': _serializePauseHistory(history),
    });
  }

  Future<void> setPassFail(String experimentId, PassFailResult? result) {
    return _experimentsCollection.doc(experimentId).set(<String, dynamic>{
      'passFailResult': result?.value,
    }, SetOptions(merge: true));
  }

  Future<void> replaceSubtasks(
    String experimentId,
    List<ExperimentSubtask> subtasks,
  ) {
    final normalized = List<ExperimentSubtask>.from(subtasks)
      ..sort((a, b) => a.order.compareTo(b.order));

    return _experimentsCollection.doc(experimentId).set(<String, dynamic>{
      'subtasks': _serializeSubtasks(normalized),
    }, SetOptions(merge: true));
  }

  Stream<List<TodayDueItem>> watchTodayDueItems(String userId, DateTime now) {
    return _experimentsCollection
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: ExperimentStatus.active.value)
        .orderBy('startDate', descending: false)
        .snapshots()
        .asyncMap((snapshot) async {
          final experiments = snapshot.docs.map((
            QueryDocumentSnapshot<Map<String, dynamic>> doc,
          ) {
            return ExperimentModel.fromDoc(doc);
          }).toList();

          if (experiments.isEmpty) {
            return const <TodayDueItem>[];
          }

          final labNames = await _resolveLabNames(experiments);
          final List<TodayDueItem> items = <TodayDueItem>[];

          for (final experiment in experiments) {
            if (!_isDueOnDate(experiment, now)) {
              continue;
            }
            final checked = await _hasCompletedCheckinForDate(
              experiment.id,
              now,
            );
            items.add(
              TodayDueItem(
                experiment: experiment.toEntity(),
                labName: labNames[experiment.labId] ?? 'Lab',
                isCheckedInToday: checked,
              ),
            );
          }

          items.sort((a, b) {
            final byLab = a.labName.toLowerCase().compareTo(
              b.labName.toLowerCase(),
            );
            if (byLab != 0) {
              return byLab;
            }
            return a.experiment.name.toLowerCase().compareTo(
              b.experiment.name.toLowerCase(),
            );
          });

          return items;
        });
  }

  Future<ExperimentAnalytics> computeAnalytics(
    String experimentId,
    DateTime now,
  ) async {
    final snapshot = await _experimentsCollection.doc(experimentId).get();
    if (!snapshot.exists) {
      return const ExperimentAnalytics(
        completionPercent: 0,
        currentStreak: 0,
        bestStreak: 0,
        totalDaysCompleted: 0,
        missedDays: 0,
      );
    }

    final experiment = ExperimentModel.fromDoc(snapshot);
    final checkins = await _experimentsCollection
        .doc(experimentId)
        .collection('checkins')
        .get();

    final Map<String, _CheckinFlags> checkinByDate = <String, _CheckinFlags>{};

    for (final doc in checkins.docs) {
      final data = doc.data();
      final rawDate = data['date'];
      if (rawDate is! Timestamp) {
        continue;
      }

      final date = AppDateUtils.startOfDay(rawDate.toDate());
      final key = AppDateUtils.dateKey(date);
      checkinByDate[key] = _CheckinFlags(
        completed: data['completed'] == true,
        restDay: data['isRestDay'] == true,
        backfill: data['isBackfill'] == true,
      );
    }

    final start = AppDateUtils.startOfDay(experiment.startDate);
    var end = AppDateUtils.startOfDay(now);

    if (experiment.completedAt != null) {
      end = _minDate(end, AppDateUtils.startOfDay(experiment.completedAt!));
    }
    if (!experiment.isOpenEnded && experiment.endDate != null) {
      end = _minDate(end, AppDateUtils.startOfDay(experiment.endDate!));
    }

    if (end.isBefore(start)) {
      return const ExperimentAnalytics(
        completionPercent: 0,
        currentStreak: 0,
        bestStreak: 0,
        totalDaysCompleted: 0,
        missedDays: 0,
      );
    }

    var elapsedDueDays = 0;
    var completedDueDays = 0;
    var currentStreak = 0;
    var bestStreak = 0;
    var totalDaysCompleted = 0;
    var missedDays = 0;
    final today = AppDateUtils.startOfDay(now);

    final Map<String, CalendarDayState> dayStates =
        <String, CalendarDayState>{};

    for (
      DateTime date = start;
      !date.isAfter(end);
      date = date.add(const Duration(days: 1))
    ) {
      final key = AppDateUtils.dateKey(date);

      if (_isPausedOnDate(experiment, date)) {
        dayStates[key] = CalendarDayState.notDue;
        continue;
      }

      final due = _isDueOnDate(experiment, date);
      if (!due) {
        dayStates[key] = CalendarDayState.notDue;
        continue;
      }

      final checkin = checkinByDate[key];
      if (checkin?.restDay == true) {
        dayStates[key] = CalendarDayState.rest;
        continue;
      }

      if (checkin?.completed == true) {
        dayStates[key] = checkin!.backfill
            ? CalendarDayState.backfill
            : CalendarDayState.completed;
        elapsedDueDays += 1;
        completedDueDays += 1;
        totalDaysCompleted += 1;
        currentStreak += 1;
        bestStreak = max(bestStreak, currentStreak);
        continue;
      }

      if (AppDateUtils.isSameDay(date, today)) {
        dayStates[key] = CalendarDayState.duePending;
        elapsedDueDays += 1;
        continue;
      }

      dayStates[key] = CalendarDayState.missed;
      elapsedDueDays += 1;
      if (experiment.frequency == ExperimentFrequency.daily) {
        missedDays += 1;
      }
      currentStreak = 0;
    }

    final completionPercent = elapsedDueDays == 0
        ? 0.0
        : (completedDueDays / elapsedDueDays) * 100.0;

    return ExperimentAnalytics(
      completionPercent: completionPercent,
      currentStreak: currentStreak,
      bestStreak: bestStreak,
      totalDaysCompleted: totalDaysCompleted,
      missedDays: missedDays,
      dayStates: dayStates,
    );
  }

  Future<void> syncExpiredExperiments(String userId, DateTime now) async {
    final snapshot = await _experimentsCollection
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: ExperimentStatus.active.value)
        .where('isOpenEnded', isEqualTo: false)
        .where('endDate', isLessThanOrEqualTo: now)
        .get();

    if (snapshot.docs.isEmpty) {
      return;
    }

    final batch = _firestore.batch();
    for (final doc in snapshot.docs) {
      batch.update(doc.reference, <String, dynamic>{
        'status': ExperimentStatus.completed.value,
        'completedAt': now,
      });
    }

    await batch.commit();
  }

  Future<int> activeExperimentsCount(String userId) async {
    final query = _experimentsCollection
        .where('userId', isEqualTo: userId)
        .where(
          'status',
          whereIn: <String>[
            ExperimentStatus.active.value,
            ExperimentStatus.paused.value,
          ],
        );

    try {
      final aggregate = await query.count().get();
      return aggregate.count ?? 0;
    } catch (_) {
      final snapshot = await query.get();
      return snapshot.docs.length;
    }
  }

  DateTime? _calculateInitialEndDate(ExperimentDraft draft) {
    if (draft.isOpenEnded ||
        draft.durationValue == null ||
        draft.durationUnit == null) {
      return null;
    }

    final start = AppDateUtils.startOfDay(draft.startDate);

    switch (draft.durationUnit!) {
      case ExperimentDurationUnit.days:
        return start.add(Duration(days: draft.durationValue! - 1));
      case ExperimentDurationUnit.weeks:
        return start.add(Duration(days: (draft.durationValue! * 7) - 1));
      case ExperimentDurationUnit.months:
        return AppDateUtils.addMonths(
          start,
          draft.durationValue!,
        ).subtract(const Duration(days: 1));
    }
  }

  List<Map<String, dynamic>> _serializeSubtasks(
    List<ExperimentSubtask> subtasks,
  ) {
    final sorted = List<ExperimentSubtask>.from(subtasks)
      ..sort((a, b) => a.order.compareTo(b.order));

    return sorted.map((subtask) {
      return <String, dynamic>{
        'id': subtask.id,
        'name': subtask.name,
        'order': subtask.order,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _serializePauseHistory(List<PauseWindow> history) {
    return history.map((window) {
      return <String, dynamic>{
        'pausedAt': window.pausedAt,
        'resumedAt': window.resumedAt,
      };
    }).toList();
  }

  Future<Map<String, String>> _resolveLabNames(
    List<ExperimentModel> experiments,
  ) async {
    final Map<String, String> labs = <String, String>{};
    final ids = experiments.map((e) => e.labId).toSet();

    for (final labId in ids) {
      final doc = await _labsCollection.doc(labId).get();
      labs[labId] = doc.data()?['name'] as String? ?? 'Lab';
    }

    return labs;
  }

  Future<bool> _hasCompletedCheckinForDate(
    String experimentId,
    DateTime date,
  ) async {
    final dayStart = AppDateUtils.startOfDay(date);
    final nextDay = dayStart.add(const Duration(days: 1));

    final snapshot = await _experimentsCollection
        .doc(experimentId)
        .collection('checkins')
        .where('date', isGreaterThanOrEqualTo: dayStart)
        .where('date', isLessThan: nextDay)
        .where('completed', isEqualTo: true)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  bool _isDueOnDate(ExperimentModel experiment, DateTime date) {
    final day = AppDateUtils.startOfDay(date);
    final start = AppDateUtils.startOfDay(experiment.startDate);

    if (day.isBefore(start)) {
      return false;
    }

    if (!experiment.isOpenEnded && experiment.endDate != null) {
      final end = AppDateUtils.startOfDay(experiment.endDate!);
      if (day.isAfter(end)) {
        return false;
      }
    }

    if (experiment.completedAt != null &&
        day.isAfter(AppDateUtils.startOfDay(experiment.completedAt!))) {
      return false;
    }

    if (_isPausedOnDate(experiment, day)) {
      return false;
    }

    switch (experiment.frequency) {
      case ExperimentFrequency.daily:
        return true;
      case ExperimentFrequency.weekly:
        return day.weekday == start.weekday;
      case ExperimentFrequency.custom:
        final customDays = experiment.customDays ?? const <int>[];
        final dayIndex = day.weekday - 1;
        return customDays.contains(dayIndex);
    }
  }

  bool _isPausedOnDate(ExperimentModel experiment, DateTime day) {
    final normalizedDay = AppDateUtils.startOfDay(day);

    for (final window in experiment.pauseHistory) {
      final pauseDay = AppDateUtils.startOfDay(window.pausedAt);
      final resumeDay = AppDateUtils.startOfDay(window.resumedAt);
      if ((normalizedDay.isAtSameMomentAs(pauseDay) ||
              normalizedDay.isAfter(pauseDay)) &&
          normalizedDay.isBefore(resumeDay)) {
        return true;
      }
    }

    if (experiment.status == ExperimentStatus.paused &&
        experiment.pausedAt != null) {
      final pausedDay = AppDateUtils.startOfDay(experiment.pausedAt!);
      if (normalizedDay.isAtSameMomentAs(pausedDay) ||
          normalizedDay.isAfter(pausedDay)) {
        return true;
      }
    }

    return false;
  }

  DateTime _minDate(DateTime a, DateTime b) {
    return a.isBefore(b) ? a : b;
  }

  String? _nullable(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}

class _CheckinFlags {
  const _CheckinFlags({
    required this.completed,
    required this.restDay,
    required this.backfill,
  });

  final bool completed;
  final bool restDay;
  final bool backfill;
}
