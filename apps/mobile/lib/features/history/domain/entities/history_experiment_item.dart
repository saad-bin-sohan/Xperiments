import 'package:mobile/features/experiments/domain/entities/experiment.dart';

class HistoryExperimentItem {
  const HistoryExperimentItem({
    required this.experiment,
    required this.completionPercent,
  });

  final Experiment experiment;
  final double completionPercent;
}
