import 'package:mobile/features/experiments/domain/entities/experiment.dart';

class TodayDueItem {
  const TodayDueItem({
    required this.experiment,
    required this.labName,
    required this.isCheckedInToday,
  });

  final Experiment experiment;
  final String labName;
  final bool isCheckedInToday;
}
