import 'package:mobile/features/labs/domain/entities/lab_stats.dart';
import 'package:mobile/features/labs/domain/repositories/labs_repository.dart';

class WatchLabStats {
  const WatchLabStats(this._repository);

  final LabsRepository _repository;

  Stream<LabStats> call(String labId) {
    return _repository.watchLabStats(labId);
  }
}
