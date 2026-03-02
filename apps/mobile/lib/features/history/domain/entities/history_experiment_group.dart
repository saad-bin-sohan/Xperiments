import 'package:mobile/features/history/domain/entities/history_experiment_item.dart';

class HistoryExperimentGroup {
  const HistoryExperimentGroup({
    required this.labId,
    required this.labName,
    required this.items,
  });

  final String labId;
  final String labName;
  final List<HistoryExperimentItem> items;
}
