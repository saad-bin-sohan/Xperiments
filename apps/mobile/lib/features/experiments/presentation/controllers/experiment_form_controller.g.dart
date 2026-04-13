// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experiment_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExperimentFormController)
final experimentFormControllerProvider = ExperimentFormControllerProvider._();

final class ExperimentFormControllerProvider
    extends $NotifierProvider<ExperimentFormController, AsyncValue<void>> {
  ExperimentFormControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'experimentFormControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$experimentFormControllerHash();

  @$internal
  @override
  ExperimentFormController create() => ExperimentFormController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$experimentFormControllerHash() =>
    r'f633d89b9885b8aa36fe92e79dbdce314d00bea6';

abstract class _$ExperimentFormController extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
