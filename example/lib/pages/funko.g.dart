// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funko.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(funko)
const funkoProvider = FunkoProvider._();

final class FunkoProvider
    extends $FunctionalProvider<AsyncValue<List<Funko>>, FutureOr<List<Funko>>>
    with $FutureModifier<List<Funko>>, $FutureProvider<List<Funko>> {
  const FunkoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'funkoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$funkoHash();

  @$internal
  @override
  $FutureProviderElement<List<Funko>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Funko>> create(Ref ref) {
    return funko(ref);
  }
}

String _$funkoHash() => r'8bc5c8fa40cdda57048207401c64e1fbfb54e7fa';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
