import 'package:mobile/features/labs/domain/entities/lab.dart';
import 'package:mobile/features/labs/domain/repositories/labs_repository.dart';

class WatchLabById {
  const WatchLabById(this._repository);

  final LabsRepository _repository;

  Stream<Lab?> call(String labId) {
    return _repository.watchLabById(labId);
  }
}
