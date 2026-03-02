import 'package:mobile/features/checkin/domain/repositories/checkin_repository.dart';

class MarkRestDay {
  const MarkRestDay(this._repository);

  final CheckinRepository _repository;

  Future<void> call(String experimentId, DateTime date) {
    return _repository.markRestDay(experimentId, date);
  }
}
