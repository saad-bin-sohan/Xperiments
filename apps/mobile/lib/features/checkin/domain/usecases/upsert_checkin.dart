import 'package:mobile/features/checkin/domain/entities/checkin_draft.dart';
import 'package:mobile/features/checkin/domain/entities/checkin_record.dart';
import 'package:mobile/features/checkin/domain/repositories/checkin_repository.dart';

class UpsertCheckin {
  const UpsertCheckin(this._repository);

  final CheckinRepository _repository;

  Future<CheckinRecord> call(CheckinDraft draft) {
    return _repository.upsertCheckin(draft);
  }
}
