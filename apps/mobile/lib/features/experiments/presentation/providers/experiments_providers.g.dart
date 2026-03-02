// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experiments_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(experimentsRemoteDataSource)
const experimentsRemoteDataSourceProvider =
    ExperimentsRemoteDataSourceProvider._();

final class ExperimentsRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          ExperimentsRemoteDataSource,
          ExperimentsRemoteDataSource,
          ExperimentsRemoteDataSource
        >
    with $Provider<ExperimentsRemoteDataSource> {
  const ExperimentsRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'experimentsRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$experimentsRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<ExperimentsRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExperimentsRemoteDataSource create(Ref ref) {
    return experimentsRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExperimentsRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExperimentsRemoteDataSource>(value),
    );
  }
}

String _$experimentsRemoteDataSourceHash() =>
    r'e336c69956c2d42433914bb181902a3bb2bef7c7';

@ProviderFor(experimentsRepository)
const experimentsRepositoryProvider = ExperimentsRepositoryProvider._();

final class ExperimentsRepositoryProvider
    extends
        $FunctionalProvider<
          ExperimentsRepository,
          ExperimentsRepository,
          ExperimentsRepository
        >
    with $Provider<ExperimentsRepository> {
  const ExperimentsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'experimentsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$experimentsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ExperimentsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExperimentsRepository create(Ref ref) {
    return experimentsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExperimentsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExperimentsRepository>(value),
    );
  }
}

String _$experimentsRepositoryHash() =>
    r'c985e5cde6d491797ca2a6f316a31cc092e0bd89';

@ProviderFor(createExperimentUseCase)
const createExperimentUseCaseProvider = CreateExperimentUseCaseProvider._();

final class CreateExperimentUseCaseProvider
    extends
        $FunctionalProvider<
          CreateExperiment,
          CreateExperiment,
          CreateExperiment
        >
    with $Provider<CreateExperiment> {
  const CreateExperimentUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createExperimentUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createExperimentUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateExperiment> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CreateExperiment create(Ref ref) {
    return createExperimentUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateExperiment value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateExperiment>(value),
    );
  }
}

String _$createExperimentUseCaseHash() =>
    r'77bb690568933813637b0bb6d634e5dee0430c7b';

@ProviderFor(updateExperimentUseCase)
const updateExperimentUseCaseProvider = UpdateExperimentUseCaseProvider._();

final class UpdateExperimentUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateExperiment,
          UpdateExperiment,
          UpdateExperiment
        >
    with $Provider<UpdateExperiment> {
  const UpdateExperimentUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateExperimentUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateExperimentUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateExperiment> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UpdateExperiment create(Ref ref) {
    return updateExperimentUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateExperiment value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateExperiment>(value),
    );
  }
}

String _$updateExperimentUseCaseHash() =>
    r'8b062022f20188b3ab0a8a78aa3ee45fcc8ad099';

@ProviderFor(watchLabExperimentsUseCase)
const watchLabExperimentsUseCaseProvider =
    WatchLabExperimentsUseCaseProvider._();

final class WatchLabExperimentsUseCaseProvider
    extends
        $FunctionalProvider<
          WatchLabExperiments,
          WatchLabExperiments,
          WatchLabExperiments
        >
    with $Provider<WatchLabExperiments> {
  const WatchLabExperimentsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchLabExperimentsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchLabExperimentsUseCaseHash();

  @$internal
  @override
  $ProviderElement<WatchLabExperiments> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WatchLabExperiments create(Ref ref) {
    return watchLabExperimentsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchLabExperiments value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchLabExperiments>(value),
    );
  }
}

String _$watchLabExperimentsUseCaseHash() =>
    r'671fa20e24e7d1e28947957d575cb89fc7cec628';

@ProviderFor(watchExperimentByIdUseCase)
const watchExperimentByIdUseCaseProvider =
    WatchExperimentByIdUseCaseProvider._();

final class WatchExperimentByIdUseCaseProvider
    extends
        $FunctionalProvider<
          WatchExperimentById,
          WatchExperimentById,
          WatchExperimentById
        >
    with $Provider<WatchExperimentById> {
  const WatchExperimentByIdUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchExperimentByIdUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchExperimentByIdUseCaseHash();

  @$internal
  @override
  $ProviderElement<WatchExperimentById> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WatchExperimentById create(Ref ref) {
    return watchExperimentByIdUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchExperimentById value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchExperimentById>(value),
    );
  }
}

String _$watchExperimentByIdUseCaseHash() =>
    r'6a96c0a7ea5357d68ac3189355dbf7e99bf5895f';

@ProviderFor(pauseExperimentUseCase)
const pauseExperimentUseCaseProvider = PauseExperimentUseCaseProvider._();

final class PauseExperimentUseCaseProvider
    extends
        $FunctionalProvider<PauseExperiment, PauseExperiment, PauseExperiment>
    with $Provider<PauseExperiment> {
  const PauseExperimentUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pauseExperimentUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pauseExperimentUseCaseHash();

  @$internal
  @override
  $ProviderElement<PauseExperiment> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PauseExperiment create(Ref ref) {
    return pauseExperimentUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PauseExperiment value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PauseExperiment>(value),
    );
  }
}

String _$pauseExperimentUseCaseHash() =>
    r'ff616ecea4f80d763e20d5f04a72d5034445a2c1';

@ProviderFor(resumeExperimentUseCase)
const resumeExperimentUseCaseProvider = ResumeExperimentUseCaseProvider._();

final class ResumeExperimentUseCaseProvider
    extends
        $FunctionalProvider<
          ResumeExperiment,
          ResumeExperiment,
          ResumeExperiment
        >
    with $Provider<ResumeExperiment> {
  const ResumeExperimentUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resumeExperimentUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resumeExperimentUseCaseHash();

  @$internal
  @override
  $ProviderElement<ResumeExperiment> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ResumeExperiment create(Ref ref) {
    return resumeExperimentUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResumeExperiment value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResumeExperiment>(value),
    );
  }
}

String _$resumeExperimentUseCaseHash() =>
    r'2849cd7a6c5aae2e5dab06de0021b99d6d1a4c37';

@ProviderFor(endExperimentUseCase)
const endExperimentUseCaseProvider = EndExperimentUseCaseProvider._();

final class EndExperimentUseCaseProvider
    extends $FunctionalProvider<EndExperiment, EndExperiment, EndExperiment>
    with $Provider<EndExperiment> {
  const EndExperimentUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'endExperimentUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$endExperimentUseCaseHash();

  @$internal
  @override
  $ProviderElement<EndExperiment> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EndExperiment create(Ref ref) {
    return endExperimentUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EndExperiment value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EndExperiment>(value),
    );
  }
}

String _$endExperimentUseCaseHash() =>
    r'253d6df83ea061cbfbdb54aad936dfd5a7260240';

@ProviderFor(setPassFailUseCase)
const setPassFailUseCaseProvider = SetPassFailUseCaseProvider._();

final class SetPassFailUseCaseProvider
    extends $FunctionalProvider<SetPassFail, SetPassFail, SetPassFail>
    with $Provider<SetPassFail> {
  const SetPassFailUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setPassFailUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setPassFailUseCaseHash();

  @$internal
  @override
  $ProviderElement<SetPassFail> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SetPassFail create(Ref ref) {
    return setPassFailUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SetPassFail value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SetPassFail>(value),
    );
  }
}

String _$setPassFailUseCaseHash() =>
    r'9c4ae65bbc6b0bffaee52230cc7058a5dacbd138';

@ProviderFor(replaceSubtasksUseCase)
const replaceSubtasksUseCaseProvider = ReplaceSubtasksUseCaseProvider._();

final class ReplaceSubtasksUseCaseProvider
    extends
        $FunctionalProvider<ReplaceSubtasks, ReplaceSubtasks, ReplaceSubtasks>
    with $Provider<ReplaceSubtasks> {
  const ReplaceSubtasksUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replaceSubtasksUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replaceSubtasksUseCaseHash();

  @$internal
  @override
  $ProviderElement<ReplaceSubtasks> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReplaceSubtasks create(Ref ref) {
    return replaceSubtasksUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplaceSubtasks value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplaceSubtasks>(value),
    );
  }
}

String _$replaceSubtasksUseCaseHash() =>
    r'1637ad61d26fd2ccb6535e5a3437a637b4f4599f';

@ProviderFor(watchTodayDueItemsUseCase)
const watchTodayDueItemsUseCaseProvider = WatchTodayDueItemsUseCaseProvider._();

final class WatchTodayDueItemsUseCaseProvider
    extends
        $FunctionalProvider<
          WatchTodayDueItems,
          WatchTodayDueItems,
          WatchTodayDueItems
        >
    with $Provider<WatchTodayDueItems> {
  const WatchTodayDueItemsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchTodayDueItemsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchTodayDueItemsUseCaseHash();

  @$internal
  @override
  $ProviderElement<WatchTodayDueItems> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WatchTodayDueItems create(Ref ref) {
    return watchTodayDueItemsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchTodayDueItems value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchTodayDueItems>(value),
    );
  }
}

String _$watchTodayDueItemsUseCaseHash() =>
    r'14fee92096236a8da2070026341345e61353e1c2';

@ProviderFor(computeExperimentAnalyticsUseCase)
const computeExperimentAnalyticsUseCaseProvider =
    ComputeExperimentAnalyticsUseCaseProvider._();

final class ComputeExperimentAnalyticsUseCaseProvider
    extends
        $FunctionalProvider<
          ComputeExperimentAnalytics,
          ComputeExperimentAnalytics,
          ComputeExperimentAnalytics
        >
    with $Provider<ComputeExperimentAnalytics> {
  const ComputeExperimentAnalyticsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'computeExperimentAnalyticsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$computeExperimentAnalyticsUseCaseHash();

  @$internal
  @override
  $ProviderElement<ComputeExperimentAnalytics> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ComputeExperimentAnalytics create(Ref ref) {
    return computeExperimentAnalyticsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ComputeExperimentAnalytics value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ComputeExperimentAnalytics>(value),
    );
  }
}

String _$computeExperimentAnalyticsUseCaseHash() =>
    r'29b0b590187163c8666f8cb6e036cf3b868a4374';

@ProviderFor(syncExpiredExperimentsUseCase)
const syncExpiredExperimentsUseCaseProvider =
    SyncExpiredExperimentsUseCaseProvider._();

final class SyncExpiredExperimentsUseCaseProvider
    extends
        $FunctionalProvider<
          SyncExpiredExperiments,
          SyncExpiredExperiments,
          SyncExpiredExperiments
        >
    with $Provider<SyncExpiredExperiments> {
  const SyncExpiredExperimentsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncExpiredExperimentsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncExpiredExperimentsUseCaseHash();

  @$internal
  @override
  $ProviderElement<SyncExpiredExperiments> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SyncExpiredExperiments create(Ref ref) {
    return syncExpiredExperimentsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncExpiredExperiments value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncExpiredExperiments>(value),
    );
  }
}

String _$syncExpiredExperimentsUseCaseHash() =>
    r'dd4bd6e21bf541acf77fd902201d610ae55ea35e';

@ProviderFor(activeExperimentsCountUseCase)
const activeExperimentsCountUseCaseProvider =
    ActiveExperimentsCountUseCaseProvider._();

final class ActiveExperimentsCountUseCaseProvider
    extends
        $FunctionalProvider<
          ActiveExperimentsCount,
          ActiveExperimentsCount,
          ActiveExperimentsCount
        >
    with $Provider<ActiveExperimentsCount> {
  const ActiveExperimentsCountUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeExperimentsCountUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeExperimentsCountUseCaseHash();

  @$internal
  @override
  $ProviderElement<ActiveExperimentsCount> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ActiveExperimentsCount create(Ref ref) {
    return activeExperimentsCountUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActiveExperimentsCount value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActiveExperimentsCount>(value),
    );
  }
}

String _$activeExperimentsCountUseCaseHash() =>
    r'a0e58dc4d17b01f32a1f24953473fda027f193b9';

@ProviderFor(labExperiments)
const labExperimentsProvider = LabExperimentsFamily._();

final class LabExperimentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Experiment>>,
          List<Experiment>,
          Stream<List<Experiment>>
        >
    with $FutureModifier<List<Experiment>>, $StreamProvider<List<Experiment>> {
  const LabExperimentsProvider._({
    required LabExperimentsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'labExperimentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$labExperimentsHash();

  @override
  String toString() {
    return r'labExperimentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Experiment>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Experiment>> create(Ref ref) {
    final argument = this.argument as String;
    return labExperiments(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LabExperimentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$labExperimentsHash() => r'a4d96f0a2f625ca6c0d27c22a017be74430ac27b';

final class LabExperimentsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Experiment>>, String> {
  const LabExperimentsFamily._()
    : super(
        retry: null,
        name: r'labExperimentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LabExperimentsProvider call(String labId) =>
      LabExperimentsProvider._(argument: labId, from: this);

  @override
  String toString() => r'labExperimentsProvider';
}

@ProviderFor(experimentById)
const experimentByIdProvider = ExperimentByIdFamily._();

final class ExperimentByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Experiment?>,
          Experiment?,
          Stream<Experiment?>
        >
    with $FutureModifier<Experiment?>, $StreamProvider<Experiment?> {
  const ExperimentByIdProvider._({
    required ExperimentByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'experimentByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$experimentByIdHash();

  @override
  String toString() {
    return r'experimentByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Experiment?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Experiment?> create(Ref ref) {
    final argument = this.argument as String;
    return experimentById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ExperimentByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$experimentByIdHash() => r'0559ab71ee03174d066c836c7889c8b2a8d1e454';

final class ExperimentByIdFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Experiment?>, String> {
  const ExperimentByIdFamily._()
    : super(
        retry: null,
        name: r'experimentByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ExperimentByIdProvider call(String experimentId) =>
      ExperimentByIdProvider._(argument: experimentId, from: this);

  @override
  String toString() => r'experimentByIdProvider';
}

@ProviderFor(todayDueItems)
const todayDueItemsProvider = TodayDueItemsProvider._();

final class TodayDueItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TodayDueItem>>,
          List<TodayDueItem>,
          Stream<List<TodayDueItem>>
        >
    with
        $FutureModifier<List<TodayDueItem>>,
        $StreamProvider<List<TodayDueItem>> {
  const TodayDueItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayDueItemsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayDueItemsHash();

  @$internal
  @override
  $StreamProviderElement<List<TodayDueItem>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TodayDueItem>> create(Ref ref) {
    return todayDueItems(ref);
  }
}

String _$todayDueItemsHash() => r'0afcbedb3a518903280be06870ffd4c959a9cb50';

@ProviderFor(experimentAnalytics)
const experimentAnalyticsProvider = ExperimentAnalyticsFamily._();

final class ExperimentAnalyticsProvider
    extends
        $FunctionalProvider<
          AsyncValue<ExperimentAnalytics>,
          ExperimentAnalytics,
          FutureOr<ExperimentAnalytics>
        >
    with
        $FutureModifier<ExperimentAnalytics>,
        $FutureProvider<ExperimentAnalytics> {
  const ExperimentAnalyticsProvider._({
    required ExperimentAnalyticsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'experimentAnalyticsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$experimentAnalyticsHash();

  @override
  String toString() {
    return r'experimentAnalyticsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ExperimentAnalytics> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ExperimentAnalytics> create(Ref ref) {
    final argument = this.argument as String;
    return experimentAnalytics(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ExperimentAnalyticsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$experimentAnalyticsHash() =>
    r'1021247169be8f16fe0c820da420c1c6497ab0b5';

final class ExperimentAnalyticsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ExperimentAnalytics>, String> {
  const ExperimentAnalyticsFamily._()
    : super(
        retry: null,
        name: r'experimentAnalyticsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ExperimentAnalyticsProvider call(String experimentId) =>
      ExperimentAnalyticsProvider._(argument: experimentId, from: this);

  @override
  String toString() => r'experimentAnalyticsProvider';
}

@ProviderFor(syncCurrentUserExpiredExperiments)
const syncCurrentUserExpiredExperimentsProvider =
    SyncCurrentUserExpiredExperimentsProvider._();

final class SyncCurrentUserExpiredExperimentsProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const SyncCurrentUserExpiredExperimentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncCurrentUserExpiredExperimentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$syncCurrentUserExpiredExperimentsHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return syncCurrentUserExpiredExperiments(ref);
  }
}

String _$syncCurrentUserExpiredExperimentsHash() =>
    r'8b72279cb6b06d5b92e687611820c6ccf4710636';

@ProviderFor(activeExperimentsCount)
const activeExperimentsCountProvider = ActiveExperimentsCountProvider._();

final class ActiveExperimentsCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  const ActiveExperimentsCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeExperimentsCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeExperimentsCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return activeExperimentsCount(ref);
  }
}

String _$activeExperimentsCountHash() =>
    r'8c5c67858c4dc09cd63d8689291bad54c624b653';

@ProviderFor(passFailFeatureVisible)
const passFailFeatureVisibleProvider = PassFailFeatureVisibleProvider._();

final class PassFailFeatureVisibleProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const PassFailFeatureVisibleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'passFailFeatureVisibleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$passFailFeatureVisibleHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return passFailFeatureVisible(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$passFailFeatureVisibleHash() =>
    r'7c1f10670d7c73c4cc563dd7acd4b5d85f4949d9';
