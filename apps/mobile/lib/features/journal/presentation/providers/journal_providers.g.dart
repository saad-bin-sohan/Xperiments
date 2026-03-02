// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(journalRemoteDataSource)
const journalRemoteDataSourceProvider = JournalRemoteDataSourceProvider._();

final class JournalRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          JournalRemoteDataSource,
          JournalRemoteDataSource,
          JournalRemoteDataSource
        >
    with $Provider<JournalRemoteDataSource> {
  const JournalRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journalRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<JournalRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  JournalRemoteDataSource create(Ref ref) {
    return journalRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JournalRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JournalRemoteDataSource>(value),
    );
  }
}

String _$journalRemoteDataSourceHash() =>
    r'c7f9fa1deb7b27087feff13477617284811c766a';

@ProviderFor(journalRepository)
const journalRepositoryProvider = JournalRepositoryProvider._();

final class JournalRepositoryProvider
    extends
        $FunctionalProvider<
          JournalRepository,
          JournalRepository,
          JournalRepository
        >
    with $Provider<JournalRepository> {
  const JournalRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journalRepositoryHash();

  @$internal
  @override
  $ProviderElement<JournalRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  JournalRepository create(Ref ref) {
    return journalRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JournalRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JournalRepository>(value),
    );
  }
}

String _$journalRepositoryHash() => r'94c8dba652a4e1ff7a38bf955ab26291b9d89b43';

@ProviderFor(watchLabEntriesUseCase)
const watchLabEntriesUseCaseProvider = WatchLabEntriesUseCaseProvider._();

final class WatchLabEntriesUseCaseProvider
    extends
        $FunctionalProvider<WatchLabEntries, WatchLabEntries, WatchLabEntries>
    with $Provider<WatchLabEntries> {
  const WatchLabEntriesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchLabEntriesUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchLabEntriesUseCaseHash();

  @$internal
  @override
  $ProviderElement<WatchLabEntries> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchLabEntries create(Ref ref) {
    return watchLabEntriesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchLabEntries value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchLabEntries>(value),
    );
  }
}

String _$watchLabEntriesUseCaseHash() =>
    r'6b3639f9ded0694120f56008026e8b8b15ff0230';

@ProviderFor(saveJournalEntryUseCase)
const saveJournalEntryUseCaseProvider = SaveJournalEntryUseCaseProvider._();

final class SaveJournalEntryUseCaseProvider
    extends
        $FunctionalProvider<
          SaveJournalEntry,
          SaveJournalEntry,
          SaveJournalEntry
        >
    with $Provider<SaveJournalEntry> {
  const SaveJournalEntryUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveJournalEntryUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveJournalEntryUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveJournalEntry> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SaveJournalEntry create(Ref ref) {
    return saveJournalEntryUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveJournalEntry value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveJournalEntry>(value),
    );
  }
}

String _$saveJournalEntryUseCaseHash() =>
    r'e6ca4fba320818748d557dd9a5181f730369c345';

@ProviderFor(deleteJournalEntryUseCase)
const deleteJournalEntryUseCaseProvider = DeleteJournalEntryUseCaseProvider._();

final class DeleteJournalEntryUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteJournalEntry,
          DeleteJournalEntry,
          DeleteJournalEntry
        >
    with $Provider<DeleteJournalEntry> {
  const DeleteJournalEntryUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteJournalEntryUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteJournalEntryUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteJournalEntry> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteJournalEntry create(Ref ref) {
    return deleteJournalEntryUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteJournalEntry value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteJournalEntry>(value),
    );
  }
}

String _$deleteJournalEntryUseCaseHash() =>
    r'1dc2e112eea573a0911562a2a2e15b5348453547';

@ProviderFor(searchLabEntriesUseCase)
const searchLabEntriesUseCaseProvider = SearchLabEntriesUseCaseProvider._();

final class SearchLabEntriesUseCaseProvider
    extends
        $FunctionalProvider<
          SearchLabEntries,
          SearchLabEntries,
          SearchLabEntries
        >
    with $Provider<SearchLabEntries> {
  const SearchLabEntriesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchLabEntriesUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchLabEntriesUseCaseHash();

  @$internal
  @override
  $ProviderElement<SearchLabEntries> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchLabEntries create(Ref ref) {
    return searchLabEntriesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchLabEntries value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchLabEntries>(value),
    );
  }
}

String _$searchLabEntriesUseCaseHash() =>
    r'ec78d370293e719945afcfd190e740a30f079af8';

@ProviderFor(labJournalEntries)
const labJournalEntriesProvider = LabJournalEntriesFamily._();

final class LabJournalEntriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<JournalEntry>>,
          List<JournalEntry>,
          Stream<List<JournalEntry>>
        >
    with
        $FutureModifier<List<JournalEntry>>,
        $StreamProvider<List<JournalEntry>> {
  const LabJournalEntriesProvider._({
    required LabJournalEntriesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'labJournalEntriesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$labJournalEntriesHash();

  @override
  String toString() {
    return r'labJournalEntriesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<JournalEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<JournalEntry>> create(Ref ref) {
    final argument = this.argument as String;
    return labJournalEntries(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LabJournalEntriesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$labJournalEntriesHash() => r'6818d5bed5c98b11d58cb35a04e4f2bb8cb10262';

final class LabJournalEntriesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<JournalEntry>>, String> {
  const LabJournalEntriesFamily._()
    : super(
        retry: null,
        name: r'labJournalEntriesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LabJournalEntriesProvider call(String labId) =>
      LabJournalEntriesProvider._(argument: labId, from: this);

  @override
  String toString() => r'labJournalEntriesProvider';
}

@ProviderFor(labJournalSearch)
const labJournalSearchProvider = LabJournalSearchFamily._();

final class LabJournalSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<JournalEntry>>,
          List<JournalEntry>,
          FutureOr<List<JournalEntry>>
        >
    with
        $FutureModifier<List<JournalEntry>>,
        $FutureProvider<List<JournalEntry>> {
  const LabJournalSearchProvider._({
    required LabJournalSearchFamily super.from,
    required ({String labId, String query}) super.argument,
  }) : super(
         retry: null,
         name: r'labJournalSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$labJournalSearchHash();

  @override
  String toString() {
    return r'labJournalSearchProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<JournalEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<JournalEntry>> create(Ref ref) {
    final argument = this.argument as ({String labId, String query});
    return labJournalSearch(ref, labId: argument.labId, query: argument.query);
  }

  @override
  bool operator ==(Object other) {
    return other is LabJournalSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$labJournalSearchHash() => r'3322183fd7a6ab96ea4f96fd0bd4f4da27fb306b';

final class LabJournalSearchFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<JournalEntry>>,
          ({String labId, String query})
        > {
  const LabJournalSearchFamily._()
    : super(
        retry: null,
        name: r'labJournalSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LabJournalSearchProvider call({
    required String labId,
    required String query,
  }) => LabJournalSearchProvider._(
    argument: (labId: labId, query: query),
    from: this,
  );

  @override
  String toString() => r'labJournalSearchProvider';
}
