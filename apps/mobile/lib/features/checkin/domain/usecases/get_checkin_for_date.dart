import 'package:mobile/features/checkin/domain/entities/checkin_record.dart';
import 'package:mobile/features/checkin/domain/repositories/checkin_repository.dart';

class GetCheckinForDate {
  const GetCheckinForDate(this._repository);

  final CheckinRepository _repository;

  Future<CheckinRecord?> call(String experimentId, DateTime date) {
    return _repository.getCheckinForDate(experimentId, date);
  }
}
