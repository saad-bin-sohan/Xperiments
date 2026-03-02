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
