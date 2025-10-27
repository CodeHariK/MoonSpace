// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_theme.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GlobalTheme)
const globalThemeProvider = GlobalThemeProvider._();

final class GlobalThemeProvider
    extends $NotifierProvider<GlobalTheme, GlobalAppTheme> {
  const GlobalThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalThemeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalThemeHash();

  @$internal
  @override
  GlobalTheme create() => GlobalTheme();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GlobalAppTheme value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GlobalAppTheme>(value),
    );
  }
}

String _$globalThemeHash() => r'0d19ca9c9ce572efd5f5d8546c98a1e037a72b9f';

abstract class _$GlobalTheme extends $Notifier<GlobalAppTheme> {
  GlobalAppTheme build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<GlobalAppTheme, GlobalAppTheme>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GlobalAppTheme, GlobalAppTheme>,
              GlobalAppTheme,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
