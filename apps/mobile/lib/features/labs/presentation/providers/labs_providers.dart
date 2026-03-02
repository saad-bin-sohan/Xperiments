import 'package:mobile/core/firebase/firebase_providers.dart';
import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/labs/data/datasources/labs_remote_data_source.dart';
import 'package:mobile/features/labs/data/repositories/labs_repository_impl.dart';
import 'package:mobile/features/labs/domain/entities/lab.dart';
import 'package:mobile/features/labs/domain/repositories/labs_repository.dart';
import 'package:mobile/features/labs/domain/usecases/ensure_default_lab_exists.dart';
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

@riverpod
Stream<List<Lab>> currentUserLabs(Ref ref) {
  final session = ref.watch(authSessionProvider).asData?.value;
  final user = session?.user;

  if (user == null) {
    return Stream<List<Lab>>.value(const <Lab>[]);
  }

  return ref.watch(watchUserLabsUseCaseProvider).call(user.id);
}
