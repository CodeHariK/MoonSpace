// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pref.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Pref)
const prefProvider = PrefProvider._();

final class PrefProvider
    extends $AsyncNotifierProvider<Pref, SharedPreferences> {
  const PrefProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prefProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prefHash();

  @$internal
  @override
  Pref create() => Pref();
}

String _$prefHash() => r'85d3935b874dab33bc3e28690e7b9f2f9e80d389';

abstract class _$Pref extends $AsyncNotifier<SharedPreferences> {
  FutureOr<SharedPreferences> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<SharedPreferences>, SharedPreferences>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SharedPreferences>, SharedPreferences>,
              AsyncValue<SharedPreferences>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
