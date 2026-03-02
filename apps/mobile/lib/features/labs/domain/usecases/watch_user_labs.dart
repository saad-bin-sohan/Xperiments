import 'package:mobile/features/labs/domain/entities/lab.dart';
import 'package:mobile/features/labs/domain/repositories/labs_repository.dart';

class WatchUserLabs {
  const WatchUserLabs(this._repository);

  final LabsRepository _repository;

  Stream<List<Lab>> call(String userId) {
    return _repository.watchUserLabs(userId);
  }
}
