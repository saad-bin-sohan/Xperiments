// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experiment_action_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExperimentActionController)
const experimentActionControllerProvider =
    ExperimentActionControllerProvider._();

final class ExperimentActionControllerProvider
    extends $NotifierProvider<ExperimentActionController, AsyncValue<void>> {
  const ExperimentActionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'experimentActionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$experimentActionControllerHash();

  @$internal
  @override
  ExperimentActionController create() => ExperimentActionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$experimentActionControllerHash() =>
    r'040da8e1844d4fe315a0eabaa80a3c5c1aa04003';

abstract class _$ExperimentActionController
    extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
