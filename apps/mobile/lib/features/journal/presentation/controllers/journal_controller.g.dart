// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(JournalController)
const journalControllerProvider = JournalControllerProvider._();

final class JournalControllerProvider
    extends $NotifierProvider<JournalController, AsyncValue<void>> {
  const JournalControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journalControllerHash();

  @$internal
  @override
  JournalController create() => JournalController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$journalControllerHash() => r'6d24004387665c296304182c12370a762447ca6d';

abstract class _$JournalController extends $Notifier<AsyncValue<void>> {
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
