import 'package:mobile/core/firebase/firebase_providers.dart';
import 'package:mobile/features/checkin/data/datasources/checkin_remote_data_source.dart';
import 'package:mobile/features/checkin/data/repositories/checkin_repository_impl.dart';
import 'package:mobile/features/checkin/domain/entities/checkin_record.dart';
import 'package:mobile/features/checkin/domain/repositories/checkin_repository.dart';
import 'package:mobile/features/checkin/domain/usecases/get_checkin_for_date.dart';
import 'package:mobile/features/checkin/domain/usecases/mark_rest_day.dart';
import 'package:mobile/features/checkin/domain/usecases/upload_checkin_photo.dart';
import 'package:mobile/features/checkin/domain/usecases/upsert_checkin.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checkin_providers.g.dart';

class CheckinLookupArgs {
  const CheckinLookupArgs({required this.experimentId, required this.date});

  final String experimentId;
  final DateTime date;
}

@Riverpod(keepAlive: true)
CheckinRemoteDataSource checkinRemoteDataSource(Ref ref) {
  return CheckinRemoteDataSource(ref.watch(firestoreProvider));
}

@Riverpod(keepAlive: true)
CheckinRepository checkinRepository(Ref ref) {
  return CheckinRepositoryImpl(ref.watch(checkinRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
GetCheckinForDate getCheckinForDateUseCase(Ref ref) {
  return GetCheckinForDate(ref.watch(checkinRepositoryProvider));
}

@Riverpod(keepAlive: true)
UpsertCheckin upsertCheckinUseCase(Ref ref) {
  return UpsertCheckin(ref.watch(checkinRepositoryProvider));
}

@Riverpod(keepAlive: true)
MarkRestDay markRestDayUseCase(Ref ref) {
  return MarkRestDay(ref.watch(checkinRepositoryProvider));
}

@Riverpod(keepAlive: true)
UploadCheckinPhoto uploadCheckinPhotoUseCase(Ref ref) {
  return UploadCheckinPhoto(ref.watch(checkinRepositoryProvider));
}

@riverpod
Future<CheckinRecord?> checkinForDate(Ref ref, CheckinLookupArgs args) {
  return ref
      .watch(getCheckinForDateUseCaseProvider)
      .call(args.experimentId, args.date);
}
