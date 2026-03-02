import 'package:mobile/features/checkin/domain/repositories/checkin_repository.dart';

class UploadCheckinPhoto {
  const UploadCheckinPhoto(this._repository);

  final CheckinRepository _repository;

  Future<String?> call({
    required String userId,
    required String experimentId,
    required DateTime date,
    required String localPath,
  }) {
    return _repository.uploadCheckinPhoto(
      userId: userId,
      experimentId: experimentId,
      date: date,
      localPath: localPath,
    );
  }
}
