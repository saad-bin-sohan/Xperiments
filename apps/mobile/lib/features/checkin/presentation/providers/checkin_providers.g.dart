// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(checkinRemoteDataSource)
final checkinRemoteDataSourceProvider = CheckinRemoteDataSourceProvider._();

final class CheckinRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          CheckinRemoteDataSource,
          CheckinRemoteDataSource,
          CheckinRemoteDataSource
        >
    with $Provider<CheckinRemoteDataSource> {
  CheckinRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkinRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkinRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<CheckinRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CheckinRemoteDataSource create(Ref ref) {
    return checkinRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CheckinRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CheckinRemoteDataSource>(value),
    );
  }
}

String _$checkinRemoteDataSourceHash() =>
    r'0d51bceb3e82ec3a4412fa51c1734f7e721bb1c6';

@ProviderFor(checkinRepository)
final checkinRepositoryProvider = CheckinRepositoryProvider._();

final class CheckinRepositoryProvider
    extends
        $FunctionalProvider<
          CheckinRepository,
          CheckinRepository,
          CheckinRepository
        >
    with $Provider<CheckinRepository> {
  CheckinRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkinRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkinRepositoryHash();

  @$internal
  @override
  $ProviderElement<CheckinRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CheckinRepository create(Ref ref) {
    return checkinRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CheckinRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CheckinRepository>(value),
    );
  }
}

String _$checkinRepositoryHash() => r'61977a843870fee6dbf359e45cf384a6ddeb89ee';

@ProviderFor(getCheckinForDateUseCase)
final getCheckinForDateUseCaseProvider = GetCheckinForDateUseCaseProvider._();

final class GetCheckinForDateUseCaseProvider
    extends
        $FunctionalProvider<
          GetCheckinForDate,
          GetCheckinForDate,
          GetCheckinForDate
        >
    with $Provider<GetCheckinForDate> {
  GetCheckinForDateUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCheckinForDateUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCheckinForDateUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetCheckinForDate> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetCheckinForDate create(Ref ref) {
    return getCheckinForDateUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCheckinForDate value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCheckinForDate>(value),
    );
  }
}

String _$getCheckinForDateUseCaseHash() =>
    r'b4f7ea5d7a18eb7f22cae956dec87d0022bd5584';

@ProviderFor(upsertCheckinUseCase)
final upsertCheckinUseCaseProvider = UpsertCheckinUseCaseProvider._();

final class UpsertCheckinUseCaseProvider
    extends $FunctionalProvider<UpsertCheckin, UpsertCheckin, UpsertCheckin>
    with $Provider<UpsertCheckin> {
  UpsertCheckinUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'upsertCheckinUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$upsertCheckinUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpsertCheckin> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UpsertCheckin create(Ref ref) {
    return upsertCheckinUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpsertCheckin value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpsertCheckin>(value),
    );
  }
}

String _$upsertCheckinUseCaseHash() =>
    r'91a090ff0f1fea44360fc6ebac43d2fadb331a8f';

@ProviderFor(markRestDayUseCase)
final markRestDayUseCaseProvider = MarkRestDayUseCaseProvider._();

final class MarkRestDayUseCaseProvider
    extends $FunctionalProvider<MarkRestDay, MarkRestDay, MarkRestDay>
    with $Provider<MarkRestDay> {
  MarkRestDayUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'markRestDayUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$markRestDayUseCaseHash();

  @$internal
  @override
  $ProviderElement<MarkRestDay> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MarkRestDay create(Ref ref) {
    return markRestDayUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MarkRestDay value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MarkRestDay>(value),
    );
  }
}

String _$markRestDayUseCaseHash() =>
    r'51d3c30bbf7d9a117e89bec425668f2ee1aaebfe';

@ProviderFor(uploadCheckinPhotoUseCase)
final uploadCheckinPhotoUseCaseProvider = UploadCheckinPhotoUseCaseProvider._();

final class UploadCheckinPhotoUseCaseProvider
    extends
        $FunctionalProvider<
          UploadCheckinPhoto,
          UploadCheckinPhoto,
          UploadCheckinPhoto
        >
    with $Provider<UploadCheckinPhoto> {
  UploadCheckinPhotoUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uploadCheckinPhotoUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uploadCheckinPhotoUseCaseHash();

  @$internal
  @override
  $ProviderElement<UploadCheckinPhoto> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UploadCheckinPhoto create(Ref ref) {
    return uploadCheckinPhotoUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UploadCheckinPhoto value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UploadCheckinPhoto>(value),
    );
  }
}

String _$uploadCheckinPhotoUseCaseHash() =>
    r'dc28b8085194aa13745d93af7611c5702ba3eaf3';

@ProviderFor(checkinForDate)
final checkinForDateProvider = CheckinForDateFamily._();

final class CheckinForDateProvider
    extends
        $FunctionalProvider<
          AsyncValue<CheckinRecord?>,
          CheckinRecord?,
          FutureOr<CheckinRecord?>
        >
    with $FutureModifier<CheckinRecord?>, $FutureProvider<CheckinRecord?> {
  CheckinForDateProvider._({
    required CheckinForDateFamily super.from,
    required CheckinLookupArgs super.argument,
  }) : super(
         retry: null,
         name: r'checkinForDateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$checkinForDateHash();

  @override
  String toString() {
    return r'checkinForDateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CheckinRecord?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CheckinRecord?> create(Ref ref) {
    final argument = this.argument as CheckinLookupArgs;
    return checkinForDate(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckinForDateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$checkinForDateHash() => r'fbbe0c09028c75d8077651f86bc1119a8b84a12e';

final class CheckinForDateFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<CheckinRecord?>, CheckinLookupArgs> {
  CheckinForDateFamily._()
    : super(
        retry: null,
        name: r'checkinForDateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CheckinForDateProvider call(CheckinLookupArgs args) =>
      CheckinForDateProvider._(argument: args, from: this);

  @override
  String toString() => r'checkinForDateProvider';
}
