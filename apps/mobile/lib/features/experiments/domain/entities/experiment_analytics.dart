import 'package:mobile/features/experiments/domain/entities/experiment.dart';

class ExperimentAnalytics {
  const ExperimentAnalytics({
    required this.completionPercent,
    required this.currentStreak,
    required this.bestStreak,
    required this.totalDaysCompleted,
    required this.missedDays,
    this.dayStates = const <String, CalendarDayState>{},
  });

  final double completionPercent;
  final int currentStreak;
  final int bestStreak;
  final int totalDaysCompleted;
  final int missedDays;
  final Map<String, CalendarDayState> dayStates;
}
