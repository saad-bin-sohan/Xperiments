import 'package:mobile/features/checkin/domain/entities/checkin_draft.dart';
import 'package:mobile/features/checkin/domain/entities/checkin_record.dart';

abstract class CheckinRepository {
  Future<CheckinRecord?> getCheckinForDate(String experimentId, DateTime date);

  Future<CheckinRecord> upsertCheckin(CheckinDraft draft);

  Future<void> markRestDay(String experimentId, DateTime date);

  Future<String?> uploadCheckinPhoto({
    required String userId,
    required String experimentId,
    required DateTime date,
    required String localPath,
  });
}
