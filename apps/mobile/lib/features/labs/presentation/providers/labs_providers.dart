import 'package:mobile/core/firebase/firebase_providers.dart';
import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/labs/data/datasources/labs_remote_data_source.dart';
import 'package:mobile/features/labs/data/repositories/labs_repository_impl.dart';
import 'package:mobile/features/labs/domain/entities/lab.dart';
import 'package:mobile/features/labs/domain/entities/lab_deletion_check.dart';
import 'package:mobile/features/labs/domain/entities/lab_stats.dart';
import 'package:mobile/features/labs/domain/repositories/labs_repository.dart';
import 'package:mobile/features/labs/domain/usecases/can_delete_lab.dart';
import 'package:mobile/features/labs/domain/usecases/create_lab.dart';
import 'package:mobile/features/labs/domain/usecases/delete_lab.dart';
import 'package:mobile/features/labs/domain/usecases/ensure_default_lab_exists.dart';
import 'package:mobile/features/labs/domain/usecases/update_lab.dart';
import 'package:mobile/features/labs/domain/usecases/watch_lab_by_id.dart';
import 'package:mobile/features/labs/domain/usecases/watch_lab_stats.dart';
import 'package:mobile/features/labs/domain/usecases/watch_user_labs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'labs_providers.g.dart';

@Riverpod(keepAlive: true)
LabsRemoteDataSource labsRemoteDataSource(Ref ref) {
  return LabsRemoteDataSource(ref.watch(firestoreProvider));
}

@Riverpod(keepAlive: true)
LabsRepository labsRepository(Ref ref) {
  return LabsRepositoryImpl(ref.watch(labsRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
EnsureDefaultLabExists ensureDefaultLabExistsUseCase(Ref ref) {
  return EnsureDefaultLabExists(ref.watch(labsRepositoryProvider));
}

@Riverpod(keepAlive: true)
WatchUserLabs watchUserLabsUseCase(Ref ref) {
  return WatchUserLabs(ref.watch(labsRepositoryProvider));
}

@Riverpod(keepAlive: true)
CreateLab createLabUseCase(Ref ref) {
  return CreateLab(ref.watch(labsRepositoryProvider));
}

@Riverpod(keepAlive: true)
UpdateLab updateLabUseCase(Ref ref) {
  return UpdateLab(ref.watch(labsRepositoryProvider));
}

@Riverpod(keepAlive: true)
DeleteLab deleteLabUseCase(Ref ref) {
  return DeleteLab(ref.watch(labsRepositoryProvider));
}

@Riverpod(keepAlive: true)
WatchLabById watchLabByIdUseCase(Ref ref) {
  return WatchLabById(ref.watch(labsRepositoryProvider));
}

@Riverpod(keepAlive: true)
WatchLabStats watchLabStatsUseCase(Ref ref) {
  return WatchLabStats(ref.watch(labsRepositoryProvider));
}

@Riverpod(keepAlive: true)
CanDeleteLab canDeleteLabUseCase(Ref ref) {
  return CanDeleteLab(ref.watch(labsRepositoryProvider));
}

@riverpod
Stream<List<Lab>> currentUserLabs(Ref ref) {
  final session = ref.watch(authSessionProvider).asData?.value;
  final user = session?.user;

  if (user == null) {
    return Stream<List<Lab>>.value(const <Lab>[]);
  }

  return ref.watch(watchUserLabsUseCaseProvider).call(user.id);
}

@riverpod
Stream<Lab?> labById(Ref ref, String labId) {
  return ref.watch(watchLabByIdUseCaseProvider).call(labId);
}

@riverpod
Stream<LabStats> labStats(Ref ref, String labId) {
  final session = ref.watch(authSessionProvider).asData?.value;
  final user = session?.user;

  if (user == null) {
    return Stream<LabStats>.value(
      const LabStats(totalExperiments: 0, totalCompleted: 0),
    );
  }

  return ref
      .watch(watchLabStatsUseCaseProvider)
      .call(labId: labId, userId: user.id);
}

@riverpod
Future<LabDeletionCheck> labDeletionCheck(Ref ref, String labId) {
  final session = ref.watch(authSessionProvider).asData?.value;
  final user = session?.user;

  if (user == null) {
    return Future<LabDeletionCheck>.value(
      const LabDeletionCheck(canDelete: false, reason: 'Not signed in.'),
    );
  }

  return ref
      .watch(canDeleteLabUseCaseProvider)
      .call(labId: labId, userId: user.id);
}
