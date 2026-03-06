import 'package:mobile/features/history/domain/repositories/history_repository.dart';

class SaveDebrief {
  const SaveDebrief(this._repository);

  final HistoryRepository _repository;

  Future<void> call({
    required String experimentId,
    int? regretScore,
    int? surpriseScore,
    bool? wouldRepeat,
  }) {
    return _repository.saveDebrief(
      experimentId: experimentId,
      regretScore: regretScore,
      surpriseScore: surpriseScore,
      wouldRepeat: wouldRepeat,
    );
  }
}
