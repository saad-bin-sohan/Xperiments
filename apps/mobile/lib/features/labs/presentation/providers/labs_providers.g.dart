// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'labs_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(labsRemoteDataSource)
const labsRemoteDataSourceProvider = LabsRemoteDataSourceProvider._();

final class LabsRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          LabsRemoteDataSource,
          LabsRemoteDataSource,
          LabsRemoteDataSource
        >
    with $Provider<LabsRemoteDataSource> {
  const LabsRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labsRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labsRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<LabsRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LabsRemoteDataSource create(Ref ref) {
    return labsRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LabsRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LabsRemoteDataSource>(value),
    );
  }
}

String _$labsRemoteDataSourceHash() =>
    r'b0cd736621e6a9ec7167aa159bb8fdc2851dcf2d';

@ProviderFor(labsRepository)
const labsRepositoryProvider = LabsRepositoryProvider._();

final class LabsRepositoryProvider
    extends $FunctionalProvider<LabsRepository, LabsRepository, LabsRepository>
    with $Provider<LabsRepository> {
  const LabsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labsRepositoryHash();

  @$internal
  @override
  $ProviderElement<LabsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LabsRepository create(Ref ref) {
    return labsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LabsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LabsRepository>(value),
    );
  }
}

String _$labsRepositoryHash() => r'1ff20a540cd530a028cc5b408ab1fab83e8bb32b';

@ProviderFor(ensureDefaultLabExistsUseCase)
const ensureDefaultLabExistsUseCaseProvider =
    EnsureDefaultLabExistsUseCaseProvider._();

final class EnsureDefaultLabExistsUseCaseProvider
    extends
        $FunctionalProvider<
          EnsureDefaultLabExists,
          EnsureDefaultLabExists,
          EnsureDefaultLabExists
        >
    with $Provider<EnsureDefaultLabExists> {
  const EnsureDefaultLabExistsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ensureDefaultLabExistsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ensureDefaultLabExistsUseCaseHash();

  @$internal
  @override
  $ProviderElement<EnsureDefaultLabExists> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EnsureDefaultLabExists create(Ref ref) {
    return ensureDefaultLabExistsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EnsureDefaultLabExists value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EnsureDefaultLabExists>(value),
    );
  }
}

String _$ensureDefaultLabExistsUseCaseHash() =>
    r'e7d7ac62aca0940d5d1de1314b1b8520c6b9a6c5';

@ProviderFor(watchUserLabsUseCase)
const watchUserLabsUseCaseProvider = WatchUserLabsUseCaseProvider._();

final class WatchUserLabsUseCaseProvider
    extends $FunctionalProvider<WatchUserLabs, WatchUserLabs, WatchUserLabs>
    with $Provider<WatchUserLabs> {
  const WatchUserLabsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchUserLabsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchUserLabsUseCaseHash();

  @$internal
  @override
  $ProviderElement<WatchUserLabs> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchUserLabs create(Ref ref) {
    return watchUserLabsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchUserLabs value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchUserLabs>(value),
    );
  }
}

String _$watchUserLabsUseCaseHash() =>
    r'1394543a4d7d895c17005d6a5796f9df44ce3f96';

@ProviderFor(createLabUseCase)
const createLabUseCaseProvider = CreateLabUseCaseProvider._();

final class CreateLabUseCaseProvider
    extends $FunctionalProvider<CreateLab, CreateLab, CreateLab>
    with $Provider<CreateLab> {
  const CreateLabUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createLabUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createLabUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateLab> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CreateLab create(Ref ref) {
    return createLabUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateLab value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateLab>(value),
    );
  }
}

String _$createLabUseCaseHash() => r'16420d0e7707387b435a24c4a92052d276141120';

@ProviderFor(updateLabUseCase)
const updateLabUseCaseProvider = UpdateLabUseCaseProvider._();

final class UpdateLabUseCaseProvider
    extends $FunctionalProvider<UpdateLab, UpdateLab, UpdateLab>
    with $Provider<UpdateLab> {
  const UpdateLabUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateLabUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateLabUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateLab> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UpdateLab create(Ref ref) {
    return updateLabUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateLab value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateLab>(value),
    );
  }
}

String _$updateLabUseCaseHash() => r'9b10c22e9aebf8b94db48594ed44a8c2089cc99b';

@ProviderFor(deleteLabUseCase)
const deleteLabUseCaseProvider = DeleteLabUseCaseProvider._();

final class DeleteLabUseCaseProvider
    extends $FunctionalProvider<DeleteLab, DeleteLab, DeleteLab>
    with $Provider<DeleteLab> {
  const DeleteLabUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteLabUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteLabUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteLab> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeleteLab create(Ref ref) {
    return deleteLabUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteLab value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteLab>(value),
    );
  }
}

String _$deleteLabUseCaseHash() => r'990cd87c8b7e521e74e0d2e5b5a0e4ae695ad2a0';

@ProviderFor(watchLabByIdUseCase)
const watchLabByIdUseCaseProvider = WatchLabByIdUseCaseProvider._();

final class WatchLabByIdUseCaseProvider
    extends $FunctionalProvider<WatchLabById, WatchLabById, WatchLabById>
    with $Provider<WatchLabById> {
  const WatchLabByIdUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchLabByIdUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchLabByIdUseCaseHash();

  @$internal
  @override
  $ProviderElement<WatchLabById> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchLabById create(Ref ref) {
    return watchLabByIdUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchLabById value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchLabById>(value),
    );
  }
}

String _$watchLabByIdUseCaseHash() =>
    r'ba3778d618c4039ef7128945c29aba242d20ae1f';

@ProviderFor(watchLabStatsUseCase)
const watchLabStatsUseCaseProvider = WatchLabStatsUseCaseProvider._();

final class WatchLabStatsUseCaseProvider
    extends $FunctionalProvider<WatchLabStats, WatchLabStats, WatchLabStats>
    with $Provider<WatchLabStats> {
  const WatchLabStatsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchLabStatsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchLabStatsUseCaseHash();

  @$internal
  @override
  $ProviderElement<WatchLabStats> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchLabStats create(Ref ref) {
    return watchLabStatsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchLabStats value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchLabStats>(value),
    );
  }
}

String _$watchLabStatsUseCaseHash() =>
    r'86b046e135cccb7a8dbe1e92134c5c20860dd4b7';

@ProviderFor(canDeleteLabUseCase)
const canDeleteLabUseCaseProvider = CanDeleteLabUseCaseProvider._();

final class CanDeleteLabUseCaseProvider
    extends $FunctionalProvider<CanDeleteLab, CanDeleteLab, CanDeleteLab>
    with $Provider<CanDeleteLab> {
  const CanDeleteLabUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'canDeleteLabUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$canDeleteLabUseCaseHash();

  @$internal
  @override
  $ProviderElement<CanDeleteLab> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CanDeleteLab create(Ref ref) {
    return canDeleteLabUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CanDeleteLab value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CanDeleteLab>(value),
    );
  }
}

String _$canDeleteLabUseCaseHash() =>
    r'3c0e6986a0057be219d4b49c30b2e23fd23d2e75';

@ProviderFor(currentUserLabs)
const currentUserLabsProvider = CurrentUserLabsProvider._();

final class CurrentUserLabsProvider
    extends
        $FunctionalProvider<AsyncValue<List<Lab>>, List<Lab>, Stream<List<Lab>>>
    with $FutureModifier<List<Lab>>, $StreamProvider<List<Lab>> {
  const CurrentUserLabsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserLabsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserLabsHash();

  @$internal
  @override
  $StreamProviderElement<List<Lab>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Lab>> create(Ref ref) {
    return currentUserLabs(ref);
  }
}

String _$currentUserLabsHash() => r'5a64637a3d1335a7234f3bf69d7299cfc65f3bf0';

@ProviderFor(labById)
const labByIdProvider = LabByIdFamily._();

final class LabByIdProvider
    extends $FunctionalProvider<AsyncValue<Lab?>, Lab?, Stream<Lab?>>
    with $FutureModifier<Lab?>, $StreamProvider<Lab?> {
  const LabByIdProvider._({
    required LabByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'labByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$labByIdHash();

  @override
  String toString() {
    return r'labByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Lab?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Lab?> create(Ref ref) {
    final argument = this.argument as String;
    return labById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LabByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$labByIdHash() => r'eb7a025f8db866bfe11ec2de0815fd88d9514552';

final class LabByIdFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Lab?>, String> {
  const LabByIdFamily._()
    : super(
        retry: null,
        name: r'labByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LabByIdProvider call(String labId) =>
      LabByIdProvider._(argument: labId, from: this);

  @override
  String toString() => r'labByIdProvider';
}

@ProviderFor(labStats)
const labStatsProvider = LabStatsFamily._();

final class LabStatsProvider
    extends
        $FunctionalProvider<AsyncValue<LabStats>, LabStats, Stream<LabStats>>
    with $FutureModifier<LabStats>, $StreamProvider<LabStats> {
  const LabStatsProvider._({
    required LabStatsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'labStatsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$labStatsHash();

  @override
  String toString() {
    return r'labStatsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<LabStats> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<LabStats> create(Ref ref) {
    final argument = this.argument as String;
    return labStats(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LabStatsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$labStatsHash() => r'a7641bc95072a17222753903b16e668cd28188d7';

final class LabStatsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<LabStats>, String> {
  const LabStatsFamily._()
    : super(
        retry: null,
        name: r'labStatsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LabStatsProvider call(String labId) =>
      LabStatsProvider._(argument: labId, from: this);

  @override
  String toString() => r'labStatsProvider';
}

@ProviderFor(labDeletionCheck)
const labDeletionCheckProvider = LabDeletionCheckFamily._();

final class LabDeletionCheckProvider
    extends
        $FunctionalProvider<
          AsyncValue<LabDeletionCheck>,
          LabDeletionCheck,
          FutureOr<LabDeletionCheck>
        >
    with $FutureModifier<LabDeletionCheck>, $FutureProvider<LabDeletionCheck> {
  const LabDeletionCheckProvider._({
    required LabDeletionCheckFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'labDeletionCheckProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$labDeletionCheckHash();

  @override
  String toString() {
    return r'labDeletionCheckProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LabDeletionCheck> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LabDeletionCheck> create(Ref ref) {
    final argument = this.argument as String;
    return labDeletionCheck(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LabDeletionCheckProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$labDeletionCheckHash() => r'023a59b00828dcacba3196e07291d384e1f5d6e8';

final class LabDeletionCheckFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<LabDeletionCheck>, String> {
  const LabDeletionCheckFamily._()
    : super(
        retry: null,
        name: r'labDeletionCheckProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LabDeletionCheckProvider call(String labId) =>
      LabDeletionCheckProvider._(argument: labId, from: this);

  @override
  String toString() => r'labDeletionCheckProvider';
}
