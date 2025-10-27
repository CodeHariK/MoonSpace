// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rankone.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(games)
const gamesProvider = GamesProvider._();

final class GamesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Game>>,
          List<Game>,
          FutureOr<List<Game>>
        >
    with $FutureModifier<List<Game>>, $FutureProvider<List<Game>> {
  const GamesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gamesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gamesHash();

  @$internal
  @override
  $FutureProviderElement<List<Game>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Game>> create(Ref ref) {
    return games(ref);
  }
}

String _$gamesHash() => r'2bfe4153da248c68ab9e73bcd5088d28f6bac3b8';
