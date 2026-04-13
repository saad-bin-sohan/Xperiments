// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin_flow_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CheckinFlowController)
final checkinFlowControllerProvider = CheckinFlowControllerProvider._();

final class CheckinFlowControllerProvider
    extends $NotifierProvider<CheckinFlowController, AsyncValue<void>> {
  CheckinFlowControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkinFlowControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkinFlowControllerHash();

  @$internal
  @override
  CheckinFlowController create() => CheckinFlowController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$checkinFlowControllerHash() =>
    r'e6dc32419207cc9c1be14f1328b7e8a81e47c807';

abstract class _$CheckinFlowController extends $Notifier<AsyncValue<void>> {
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
