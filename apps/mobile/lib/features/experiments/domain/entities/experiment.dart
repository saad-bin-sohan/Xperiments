import 'package:freezed_annotation/freezed_annotation.dart';

part 'experiment.freezed.dart';

enum ExperimentStatus {
  active,
  paused,
  completed,
  endedEarly;

  String get value {
    switch (this) {
      case ExperimentStatus.active:
        return 'active';
      case ExperimentStatus.paused:
        return 'paused';
      case ExperimentStatus.completed:
        return 'completed';
      case ExperimentStatus.endedEarly:
        return 'ended_early';
    }
  }

  String get label {
    switch (this) {
      case ExperimentStatus.active:
        return 'Active';
      case ExperimentStatus.paused:
        return 'Paused';
      case ExperimentStatus.completed:
        return 'Completed';
      case ExperimentStatus.endedEarly:
        return 'Ended Early';
    }
  }

  static ExperimentStatus fromValue(String? value) {
    switch (value) {
      case 'paused':
        return ExperimentStatus.paused;
      case 'completed':
        return ExperimentStatus.completed;
      case 'ended_early':
        return ExperimentStatus.endedEarly;
      case 'active':
      default:
        return ExperimentStatus.active;
    }
  }
}

enum ExperimentFrequency {
  daily,
  weekly,
  custom;

  String get value {
    switch (this) {
      case ExperimentFrequency.daily:
        return 'daily';
      case ExperimentFrequency.weekly:
        return 'weekly';
      case ExperimentFrequency.custom:
        return 'custom';
    }
  }

  String get label {
    switch (this) {
      case ExperimentFrequency.daily:
        return 'Daily';
      case ExperimentFrequency.weekly:
        return 'Weekly';
      case ExperimentFrequency.custom:
        return 'Custom Days';
    }
  }

  static ExperimentFrequency fromValue(String? value) {
    switch (value) {
      case 'weekly':
        return ExperimentFrequency.weekly;
      case 'custom':
        return ExperimentFrequency.custom;
      case 'daily':
      default:
        return ExperimentFrequency.daily;
    }
  }
}

enum ExperimentDurationUnit {
  days,
  weeks,
  months;

  String get value {
    switch (this) {
      case ExperimentDurationUnit.days:
        return 'days';
      case ExperimentDurationUnit.weeks:
        return 'weeks';
      case ExperimentDurationUnit.months:
        return 'months';
    }
  }

  String get label {
    switch (this) {
      case ExperimentDurationUnit.days:
        return 'Days';
      case ExperimentDurationUnit.weeks:
        return 'Weeks';
      case ExperimentDurationUnit.months:
        return 'Months';
    }
  }

  static ExperimentDurationUnit fromValue(String? value) {
    switch (value) {
      case 'weeks':
        return ExperimentDurationUnit.weeks;
      case 'months':
        return ExperimentDurationUnit.months;
      case 'days':
      default:
        return ExperimentDurationUnit.days;
    }
  }
}

enum PassFailResult {
  pass,
  fail;

  String get value {
    switch (this) {
      case PassFailResult.pass:
        return 'pass';
      case PassFailResult.fail:
        return 'fail';
    }
  }

  String get label {
    switch (this) {
      case PassFailResult.pass:
        return 'Pass';
      case PassFailResult.fail:
        return 'Fail';
    }
  }

  static PassFailResult? fromValue(String? value) {
    switch (value) {
      case 'pass':
        return PassFailResult.pass;
      case 'fail':
        return PassFailResult.fail;
      default:
        return null;
    }
  }
}

enum CalendarDayState { completed, missed, rest, backfill, duePending, notDue }

@freezed
abstract class ExperimentSubtask with _$ExperimentSubtask {
  const factory ExperimentSubtask({
    required String id,
    required String name,
    required int order,
  }) = _ExperimentSubtask;
}

@freezed
abstract class PauseWindow with _$PauseWindow {
  const factory PauseWindow({
    required DateTime pausedAt,
    required DateTime resumedAt,
  }) = _PauseWindow;
}

@freezed
abstract class Experiment with _$Experiment {
  const factory Experiment({
    required String id,
    required String userId,
    required String labId,
    required String name,
    String? hypothesis,
    String? motivation,
    required DateTime startDate,
    required ExperimentFrequency frequency,
    List<int>? customDays,
    required bool isOpenEnded,
    int? durationValue,
    ExperimentDurationUnit? durationUnit,
    DateTime? endDate,
    required ExperimentStatus status,
    PassFailResult? passFailResult,
    DateTime? pausedAt,
    required bool remindersEnabled,
    String? reminderTime,
    String? interferenceNote,
    required bool interferenceLogEnabled,
    required DateTime createdAt,
    DateTime? completedAt,
    String? finalReflection,
    String? lessonsLearned,
    @Default(<ExperimentSubtask>[]) List<ExperimentSubtask> subtasks,
    @Default(<PauseWindow>[]) List<PauseWindow> pauseHistory,
  }) = _Experiment;
}
