// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_gate_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authGateBootstrap)
final authGateBootstrapProvider = AuthGateBootstrapProvider._();

final class AuthGateBootstrapProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  AuthGateBootstrapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authGateBootstrapProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authGateBootstrapHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return authGateBootstrap(ref);
  }
}

String _$authGateBootstrapHash() => r'5c07a9de7e4a14c59f0609ef997d2164572a06cb';
