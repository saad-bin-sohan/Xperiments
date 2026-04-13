// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'labs_action_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LabsActionController)
final labsActionControllerProvider = LabsActionControllerProvider._();

final class LabsActionControllerProvider
    extends $NotifierProvider<LabsActionController, AsyncValue<void>> {
  LabsActionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labsActionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labsActionControllerHash();

  @$internal
  @override
  LabsActionController create() => LabsActionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$labsActionControllerHash() =>
    r'242bbee3a9328a75a350cd013804b66cfd23eaca';

abstract class _$LabsActionController extends $Notifier<AsyncValue<void>> {
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
