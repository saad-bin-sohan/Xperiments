import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/constants/firebase_collections.dart';
import 'package:mobile/core/utils/date_utils.dart';
import 'package:mobile/core/utils/text_utils.dart';
import 'package:mobile/features/experiments/data/models/experiment_model.dart';
import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/history/domain/entities/history_experiment_group.dart';
import 'package:mobile/features/history/domain/entities/history_experiment_item.dart';
import 'package:mobile/features/history/domain/entities/history_search_result.dart';
import 'package:mobile/features/history/domain/entities/summary_text_result.dart';

class HistoryRemoteDataSource {
  const HistoryRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _experimentsCollection {
    return _firestore.collection(FirebaseCollections.experiments);
  }

  CollectionReference<Map<String, dynamic>> get _labsCollection {
    return _firestore.collection(FirebaseCollections.labs);
  }

  CollectionReference<Map<String, dynamic>> get _journalCollection {
    return _firestore.collection(FirebaseCollections.journalEntries);
  }

  CollectionReference<Map<String, dynamic>> _checkinsCollection(
    String experimentId,
  ) {
    return _experimentsCollection
        .doc(experimentId)
        .collection(FirebaseCollections.checkins);
  }

  Stream<List<HistoryExperimentGroup>> watchHistoryGroupedByLab(String userId) {
    return _experimentsCollection
        .where('userId', isEqualTo: userId)
        .where(
          'status',
          whereIn: <String>[
            ExperimentStatus.completed.value,
            ExperimentStatus.endedEarly.value,
          ],
        )
        .orderBy('completedAt', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
          if (snapshot.docs.isEmpty) {
            return const <HistoryExperimentGroup>[];
          }

          final models = snapshot.docs.map((doc) {
            return ExperimentModel.fromDoc(doc);
          }).toList();

          final labNames = await _resolveLabNames(models);
          final grouped = <String, List<HistoryExperimentItem>>{};

          for (final model in models) {
            final completionPercent = await _computeCompletionPercent(
              model,
              DateTime.now(),
            );

            final itemsForLab = grouped.putIfAbsent(
              model.labId,
              () => <HistoryExperimentItem>[],
            );
            itemsForLab.add(
              HistoryExperimentItem(
                experiment: model.toEntity(),
                completionPercent: completionPercent,
              ),
            );
          }

          final groups =
              grouped.entries.map((entry) {
                final items = entry.value
                  ..sort((a, b) {
                    final aDate =
                        a.experiment.completedAt ?? a.experiment.createdAt;
                    final bDate =
                        b.experiment.completedAt ?? b.experiment.createdAt;
                    return bDate.compareTo(aDate);
                  });

                return HistoryExperimentGroup(
                  labId: entry.key,
                  labName: labNames[entry.key] ?? 'Lab',
                  items: items,
                );
              }).toList()..sort((a, b) {
                return a.labName.toLowerCase().compareTo(
                  b.labName.toLowerCase(),
                );
              });

          return groups;
        });
  }

  Future<void> saveFinalReflection(String experimentId, String? reflection) {
    return _experimentsCollection.doc(experimentId).set(<String, dynamic>{
      'finalReflection': _nullable(reflection),
    }, SetOptions(merge: true));
  }

  Future<void> saveLessonsLearned(String experimentId, String? lessons) {
    return _experimentsCollection.doc(experimentId).set(<String, dynamic>{
      'lessonsLearned': _nullable(lessons),
    }, SetOptions(merge: true));
  }

  Future<void> saveDebrief({
    required String experimentId,
    int? regretScore,
    int? surpriseScore,
    bool? wouldRepeat,
  }) {
    final data = <String, dynamic>{};
    if (regretScore != null) {
      data['regretScore'] = regretScore;
    }
    if (surpriseScore != null) {
      data['surpriseScore'] = surpriseScore;
    }
    if (wouldRepeat != null) {
      data['wouldRepeat'] = wouldRepeat;
    }
    return _experimentsCollection.doc(experimentId).set(
      data,
      SetOptions(merge: true),
    );
  }

  Future<List<HistorySearchResult>> searchHistoryContent(
    String userId,
    String query,
  ) async {
    final normalized = query.trim();
    final tokens = AppTextUtils.tokenize(normalized);
    if (tokens.isEmpty) {
      return const <HistorySearchResult>[];
    }

    final experiments = await _readHistoryExperiments(userId);
    final results = <HistorySearchResult>[];

    for (final model in experiments) {
      final experiment = model.toEntity();

      _appendMatch(
        results: results,
        tokens: tokens,
        experimentId: experiment.id,
        title: experiment.name,
        sourceText: experiment.name,
        sourceType: HistorySourceType.experimentName,
        matchedDate: experiment.completedAt ?? experiment.createdAt,
        query: normalized,
      );

      _appendMatch(
        results: results,
        tokens: tokens,
        experimentId: experiment.id,
        title: experiment.name,
        sourceText: experiment.finalReflection,
        sourceType: HistorySourceType.finalReflection,
        matchedDate: experiment.completedAt ?? experiment.createdAt,
        query: normalized,
      );

      _appendMatch(
        results: results,
        tokens: tokens,
        experimentId: experiment.id,
        title: experiment.name,
        sourceText: experiment.lessonsLearned,
        sourceType: HistorySourceType.lessonsLearned,
        matchedDate: experiment.completedAt ?? experiment.createdAt,
        query: normalized,
      );

      final checkinsSnapshot = await _checkinsCollection(experiment.id).get();
      for (final doc in checkinsSnapshot.docs) {
        final data = doc.data();
        final note = data['journalEntry'] as String?;
        if (!_matchesTokens(note, tokens)) {
          continue;
        }

        results.add(
          HistorySearchResult(
            experimentId: experiment.id,
            title: experiment.name,
            snippet: AppTextUtils.snippetForMatch(note!, normalized),
            sourceType: HistorySourceType.checkinNote,
            matchedDate: _readDate(data['date']) ?? experiment.completedAt,
          ),
        );
      }
    }

    final journalSnapshot = await _journalCollection
        .where('userId', isEqualTo: userId)
        .get();

    for (final doc in journalSnapshot.docs) {
      final data = doc.data();
      final body = data['body'] as String?;
      if (!_matchesTokens(body, tokens)) {
        continue;
      }

      results.add(
        HistorySearchResult(
          experimentId: '',
          title: 'Journal entry',
          snippet: AppTextUtils.snippetForMatch(body!, normalized),
          sourceType: HistorySourceType.journalEntry,
          matchedDate: _readDate(data['date']) ?? _readDate(data['createdAt']),
        ),
      );
    }

    results.sort((a, b) {
      final aDate = a.matchedDate;
      final bDate = b.matchedDate;
      if (aDate == null && bDate == null) {
        return 0;
      }
      if (aDate == null) {
        return 1;
      }
      if (bDate == null) {
        return -1;
      }
      return bDate.compareTo(aDate);
    });

    return results;
  }

  Future<SummaryTextResult> buildMonthlySummary(String userId, DateTime now) {
    final localNow = now.toLocal();
    final start = DateTime(localNow.year, localNow.month);
    final end = localNow.month == 12
        ? DateTime(localNow.year + 1, 1)
        : DateTime(localNow.year, localNow.month + 1);

    final periodLabel = DateFormat('MMMM yyyy').format(start);
    return _buildSummary(
      userId: userId,
      periodStart: start,
      periodEndExclusive: end,
      periodLabel: periodLabel,
      now: localNow,
    );
  }

  Future<SummaryTextResult> buildYearlySummary(String userId, DateTime now) {
    final localNow = now.toLocal();
    final start = DateTime(localNow.year, 1, 1);
    final end = DateTime(localNow.year + 1, 1, 1);

    final periodLabel = '${localNow.year}';
    return _buildSummary(
      userId: userId,
      periodStart: start,
      periodEndExclusive: end,
      periodLabel: periodLabel,
      now: localNow,
    );
  }

  Future<SummaryTextResult> _buildSummary({
    required String userId,
    required DateTime periodStart,
    required DateTime periodEndExclusive,
    required String periodLabel,
    required DateTime now,
  }) async {
    final snapshot = await _experimentsCollection
        .where('userId', isEqualTo: userId)
        .get();

    final models = snapshot.docs
        .map((doc) => ExperimentModel.fromDoc(doc))
        .toList();

    final ran = models.where((model) {
      final startDate = AppDateUtils.startOfDay(model.startDate.toLocal());
      return _isInRange(startDate, periodStart, periodEndExclusive);
    }).toList();

    final completedCount = ran.where((model) {
      return model.status == ExperimentStatus.completed;
    }).length;

    final endedEarlyCount = ran.where((model) {
      return model.status == ExperimentStatus.endedEarly;
    }).length;

    var highestStreak = 0;
    var highestStreakExperiment = 'None';
    var totalCheckins = 0;
    final moodUsage = <String, int>{};

    for (final model in models) {
      final checkinsSnapshot = await _checkinsCollection(model.id).get();
      final checkinByDate = <String, _CheckinFlags>{};

      for (final doc in checkinsSnapshot.docs) {
        final data = doc.data();
        final date = _readDate(data['date']);
        if (date == null) {
          continue;
        }

        final day = AppDateUtils.startOfDay(date.toLocal());
        final completed = data['completed'] == true;
        final rest = data['isRestDay'] == true;
        final backfill = data['isBackfill'] == true;
        final moodWords = data['moodWords'] as String?;

        checkinByDate[AppDateUtils.dateKey(day)] = _CheckinFlags(
          completed: completed,
          restDay: rest,
          backfill: backfill,
        );

        if (_isInRange(day, periodStart, periodEndExclusive) &&
            completed &&
            !rest) {
          totalCheckins += 1;
          final tokens = AppTextUtils.moodTokens(moodWords);
          for (final token in tokens) {
            moodUsage[token] = (moodUsage[token] ?? 0) + 1;
          }
        }
      }

      if (!ran.any((item) => item.id == model.id)) {
        continue;
      }

      final streak = _computeBestStreakInRange(
        model: model,
        checkins: checkinByDate,
        periodStart: periodStart,
        periodEndExclusive: periodEndExclusive,
        now: now,
      );

      if (streak > highestStreak) {
        highestStreak = streak;
        highestStreakExperiment = model.name;
      }
    }

    final topMoodWords = moodUsage.entries.toList()
      ..sort((a, b) {
        final byCount = b.value.compareTo(a.value);
        if (byCount != 0) {
          return byCount;
        }
        return a.key.compareTo(b.key);
      });

    final moodText = topMoodWords.isEmpty
        ? 'none'
        : topMoodWords.take(5).map((entry) => entry.key).join(', ');

    final text =
        'In $periodLabel, you ran ${ran.length} experiments. '
        'You completed $completedCount, ended $endedEarlyCount early. '
        'Your highest streak was $highestStreak days ($highestStreakExperiment). '
        'You checked in $totalCheckins times total. '
        'Mood words most used: $moodText.';

    return SummaryTextResult(periodLabel: periodLabel, text: text);
  }

  Future<List<ExperimentModel>> _readHistoryExperiments(String userId) async {
    final snapshot = await _experimentsCollection
        .where('userId', isEqualTo: userId)
        .where(
          'status',
          whereIn: <String>[
            ExperimentStatus.completed.value,
            ExperimentStatus.endedEarly.value,
          ],
        )
        .orderBy('completedAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => ExperimentModel.fromDoc(doc)).toList();
  }

  Future<double> _computeCompletionPercent(
    ExperimentModel model,
    DateTime now,
  ) async {
    final checkinsSnapshot = await _checkinsCollection(model.id).get();

    final checkinByDate = <String, _CheckinFlags>{};
    for (final doc in checkinsSnapshot.docs) {
      final data = doc.data();
      final date = _readDate(data['date']);
      if (date == null) {
        continue;
      }

      final key = AppDateUtils.dateKey(date);
      checkinByDate[key] = _CheckinFlags(
        completed: data['completed'] == true,
        restDay: data['isRestDay'] == true,
        backfill: data['isBackfill'] == true,
      );
    }

    final start = AppDateUtils.startOfDay(model.startDate);
    final end = _effectiveEndDate(model, now);

    var elapsedDueDays = 0;
    var completedDueDays = 0;

    for (
      DateTime day = start;
      !day.isAfter(end);
      day = day.add(const Duration(days: 1))
    ) {
      if (_isPausedOnDate(model, day) || !_isDueOnDate(model, day)) {
        continue;
      }

      final flags = checkinByDate[AppDateUtils.dateKey(day)];
      if (flags?.restDay == true) {
        continue;
      }

      elapsedDueDays += 1;
      if (flags?.completed == true) {
        completedDueDays += 1;
      }
    }

    if (elapsedDueDays == 0) {
      return 0;
    }

    return (completedDueDays / elapsedDueDays) * 100;
  }

  int _computeBestStreakInRange({
    required ExperimentModel model,
    required Map<String, _CheckinFlags> checkins,
    required DateTime periodStart,
    required DateTime periodEndExclusive,
    required DateTime now,
  }) {
    final start = _maxDate(
      AppDateUtils.startOfDay(model.startDate),
      AppDateUtils.startOfDay(periodStart),
    );

    final endBoundary = _effectiveEndDate(model, now);
    final periodEnd = AppDateUtils.startOfDay(
      periodEndExclusive,
    ).subtract(const Duration(days: 1));
    final end = _minDate(endBoundary, periodEnd);

    if (end.isBefore(start)) {
      return 0;
    }

    var current = 0;
    var best = 0;

    for (
      DateTime day = start;
      !day.isAfter(end);
      day = day.add(const Duration(days: 1))
    ) {
      if (_isPausedOnDate(model, day) || !_isDueOnDate(model, day)) {
        continue;
      }

      final flags = checkins[AppDateUtils.dateKey(day)];
      if (flags?.restDay == true) {
        continue;
      }

      if (flags?.completed == true) {
        current += 1;
        best = max(best, current);
      } else {
        current = 0;
      }
    }

    return best;
  }

  DateTime _effectiveEndDate(ExperimentModel model, DateTime now) {
    var end = AppDateUtils.startOfDay(now);

    if (model.completedAt != null) {
      end = _minDate(end, AppDateUtils.startOfDay(model.completedAt!));
    }
    if (!model.isOpenEnded && model.endDate != null) {
      end = _minDate(end, AppDateUtils.startOfDay(model.endDate!));
    }

    return end;
  }

  bool _isDueOnDate(ExperimentModel model, DateTime date) {
    final day = AppDateUtils.startOfDay(date);
    final start = AppDateUtils.startOfDay(model.startDate);

    if (day.isBefore(start)) {
      return false;
    }

    if (!model.isOpenEnded && model.endDate != null) {
      final end = AppDateUtils.startOfDay(model.endDate!);
      if (day.isAfter(end)) {
        return false;
      }
    }

    if (model.completedAt != null) {
      final completedAt = AppDateUtils.startOfDay(model.completedAt!);
      if (day.isAfter(completedAt)) {
        return false;
      }
    }

    switch (model.frequency) {
      case ExperimentFrequency.daily:
        return true;
      case ExperimentFrequency.weekly:
        return day.weekday == start.weekday;
      case ExperimentFrequency.custom:
        final customDays = model.customDays ?? const <int>[];
        return customDays.contains(day.weekday - 1);
    }
  }

  bool _isPausedOnDate(ExperimentModel model, DateTime day) {
    final normalized = AppDateUtils.startOfDay(day);

    for (final window in model.pauseHistory) {
      final paused = AppDateUtils.startOfDay(window.pausedAt);
      final resumed = AppDateUtils.startOfDay(window.resumedAt);

      if ((normalized.isAtSameMomentAs(paused) || normalized.isAfter(paused)) &&
          normalized.isBefore(resumed)) {
        return true;
      }
    }

    return false;
  }

  Future<Map<String, String>> _resolveLabNames(
    List<ExperimentModel> experiments,
  ) async {
    final ids = experiments.map((experiment) => experiment.labId).toSet();
    final names = <String, String>{};

    for (final labId in ids) {
      final snapshot = await _labsCollection.doc(labId).get();
      names[labId] = snapshot.data()?['name'] as String? ?? 'Lab';
    }

    return names;
  }

  void _appendMatch({
    required List<HistorySearchResult> results,
    required List<String> tokens,
    required String experimentId,
    required String title,
    required String? sourceText,
    required HistorySourceType sourceType,
    required DateTime? matchedDate,
    required String query,
  }) {
    if (!_matchesTokens(sourceText, tokens)) {
      return;
    }

    final raw = sourceText ?? '';
    results.add(
      HistorySearchResult(
        experimentId: experimentId,
        title: title,
        snippet: AppTextUtils.snippetForMatch(raw, query),
        sourceType: sourceType,
        matchedDate: matchedDate,
      ),
    );
  }

  bool _matchesTokens(String? input, List<String> tokens) {
    final value = input?.toLowerCase().trim();
    if (value == null || value.isEmpty) {
      return false;
    }

    for (final token in tokens) {
      if (!value.contains(token)) {
        return false;
      }
    }

    return true;
  }

  bool _isInRange(DateTime date, DateTime start, DateTime endExclusive) {
    return !date.isBefore(start) && date.isBefore(endExclusive);
  }

  DateTime _maxDate(DateTime a, DateTime b) {
    return a.isAfter(b) ? a : b;
  }

  DateTime _minDate(DateTime a, DateTime b) {
    return a.isBefore(b) ? a : b;
  }

  DateTime? _readDate(Object? raw) {
    if (raw is Timestamp) {
      return raw.toDate();
    }
    if (raw is DateTime) {
      return raw;
    }
    return null;
  }

  String? _nullable(String? input) {
    final trimmed = input?.trim();
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
