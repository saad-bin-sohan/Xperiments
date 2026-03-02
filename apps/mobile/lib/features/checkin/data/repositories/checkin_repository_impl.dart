import 'package:mobile/features/checkin/data/datasources/checkin_remote_data_source.dart';
import 'package:mobile/features/checkin/data/models/checkin_model.dart';
import 'package:mobile/features/checkin/domain/entities/checkin_draft.dart';
import 'package:mobile/features/checkin/domain/entities/checkin_record.dart';
import 'package:mobile/features/checkin/domain/repositories/checkin_repository.dart';

class CheckinRepositoryImpl implements CheckinRepository {
  const CheckinRepositoryImpl(this._remoteDataSource);

  final CheckinRemoteDataSource _remoteDataSource;

  @override
  Future<CheckinRecord?> getCheckinForDate(String experimentId, DateTime date) {
    return _remoteDataSource.getCheckinForDate(experimentId, date).then((
      model,
    ) {
      return model?.toEntity();
    });
  }

  @override
  Future<void> markRestDay(String experimentId, DateTime date) {
    return _remoteDataSource.markRestDay(experimentId, date);
  }

  @override
  Future<CheckinRecord> upsertCheckin(CheckinDraft draft) {
    return _remoteDataSource.upsertCheckin(draft).then((CheckinModel model) {
      return model.toEntity();
    });
  }

  @override
  Future<String?> uploadCheckinPhoto({
    required String userId,
    required String experimentId,
    required DateTime date,
    required String localPath,
  }) {
    return _remoteDataSource.uploadCheckinPhoto(
      userId: userId,
      experimentId: experimentId,
      date: date,
      localPath: localPath,
    );
  }
}
