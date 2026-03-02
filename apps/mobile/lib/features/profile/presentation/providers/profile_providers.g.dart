// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(preferencesRemoteDataSource)
const preferencesRemoteDataSourceProvider =
    PreferencesRemoteDataSourceProvider._();

final class PreferencesRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          PreferencesRemoteDataSource,
          PreferencesRemoteDataSource,
          PreferencesRemoteDataSource
        >
    with $Provider<PreferencesRemoteDataSource> {
  const PreferencesRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preferencesRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preferencesRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<PreferencesRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PreferencesRemoteDataSource create(Ref ref) {
    return preferencesRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PreferencesRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PreferencesRemoteDataSource>(value),
    );
  }
}

String _$preferencesRemoteDataSourceHash() =>
    r'e562cf205f863e1684112df6d38f5f544ba120eb';

@ProviderFor(preferencesRepository)
const preferencesRepositoryProvider = PreferencesRepositoryProvider._();

final class PreferencesRepositoryProvider
    extends
        $FunctionalProvider<
          PreferencesRepository,
          PreferencesRepository,
          PreferencesRepository
        >
    with $Provider<PreferencesRepository> {
  const PreferencesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preferencesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preferencesRepositoryHash();

  @$internal
  @override
  $ProviderElement<PreferencesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PreferencesRepository create(Ref ref) {
    return preferencesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PreferencesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PreferencesRepository>(value),
    );
  }
}

String _$preferencesRepositoryHash() =>
    r'8cf41e0ded8bc58b39ca2e7f9325457b84dfec22';

@ProviderFor(watchPreferencesUseCase)
const watchPreferencesUseCaseProvider = WatchPreferencesUseCaseProvider._();

final class WatchPreferencesUseCaseProvider
    extends
        $FunctionalProvider<
          WatchPreferences,
          WatchPreferences,
          WatchPreferences
        >
    with $Provider<WatchPreferences> {
  const WatchPreferencesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchPreferencesUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchPreferencesUseCaseHash();

  @$internal
  @override
  $ProviderElement<WatchPreferences> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchPreferences create(Ref ref) {
    return watchPreferencesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchPreferences>(value),
    );
  }
}

String _$watchPreferencesUseCaseHash() =>
    r'18a76395d966917303b323c93b817bdc29109a75';

@ProviderFor(updatePreferencesUseCase)
const updatePreferencesUseCaseProvider = UpdatePreferencesUseCaseProvider._();

final class UpdatePreferencesUseCaseProvider
    extends
        $FunctionalProvider<
          UpdatePreferences,
          UpdatePreferences,
          UpdatePreferences
        >
    with $Provider<UpdatePreferences> {
  const UpdatePreferencesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updatePreferencesUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updatePreferencesUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdatePreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdatePreferences create(Ref ref) {
    return updatePreferencesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdatePreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdatePreferences>(value),
    );
  }
}

String _$updatePreferencesUseCaseHash() =>
    r'e89bde2a960b0ebe3eab74b9447c85e7d497cbba';

@ProviderFor(currentUserPreferences)
const currentUserPreferencesProvider = CurrentUserPreferencesProvider._();

final class CurrentUserPreferencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserPreferences>,
          UserPreferences,
          Stream<UserPreferences>
        >
    with $FutureModifier<UserPreferences>, $StreamProvider<UserPreferences> {
  const CurrentUserPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserPreferencesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserPreferencesHash();

  @$internal
  @override
  $StreamProviderElement<UserPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<UserPreferences> create(Ref ref) {
    return currentUserPreferences(ref);
  }
}

String _$currentUserPreferencesHash() =>
    r'4381197a61f7c26cd08feb2ddf2b39b2531646e6';

@ProviderFor(passFailEnabled)
const passFailEnabledProvider = PassFailEnabledProvider._();

final class PassFailEnabledProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const PassFailEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'passFailEnabledProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$passFailEnabledHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return passFailEnabled(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$passFailEnabledHash() => r'310c35aa411e6fdd3f4acfac879a3655ffbe5bad';

@ProviderFor(currentThemeMode)
const currentThemeModeProvider = CurrentThemeModeProvider._();

final class CurrentThemeModeProvider
    extends $FunctionalProvider<ThemeMode, ThemeMode, ThemeMode>
    with $Provider<ThemeMode> {
  const CurrentThemeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentThemeModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentThemeModeHash();

  @$internal
  @override
  $ProviderElement<ThemeMode> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeMode create(Ref ref) {
    return currentThemeMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$currentThemeModeHash() => r'184f2a4e4d9aa5e849c4da9af43c7edf225214ab';
