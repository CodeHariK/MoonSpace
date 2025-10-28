// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compass.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$countriesRoute];

RouteBase get $countriesRoute => GoRouteData.$route(
  path: '/compass',
  factory: $CountriesRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: ':country',
      factory: $CountryRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: ':destination',
          factory: $ActivitiesRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: ':activites/:daterange',
              factory: $DetailsRoute._fromState,
            ),
          ],
        ),
      ],
    ),
  ],
);

mixin $CountriesRoute on GoRouteData {
  static CountriesRoute _fromState(GoRouterState state) =>
      const CountriesRoute();

  @override
  String get location => GoRouteData.$location('/compass');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CountryRoute on GoRouteData {
  static CountryRoute _fromState(GoRouterState state) =>
      CountryRoute(state.pathParameters['country']!);

  CountryRoute get _self => this as CountryRoute;

  @override
  String get location =>
      GoRouteData.$location('/compass/${Uri.encodeComponent(_self.country)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ActivitiesRoute on GoRouteData {
  static ActivitiesRoute _fromState(GoRouterState state) => ActivitiesRoute(
    state.pathParameters['country']!,
    state.pathParameters['destination']!,
  );

  ActivitiesRoute get _self => this as ActivitiesRoute;

  @override
  String get location => GoRouteData.$location(
    '/compass/${Uri.encodeComponent(_self.country)}/${Uri.encodeComponent(_self.destination)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DetailsRoute on GoRouteData {
  static DetailsRoute _fromState(GoRouterState state) => DetailsRoute(
    state.pathParameters['country']!,
    state.pathParameters['destination']!,
    state.pathParameters['activites']!,
    state.pathParameters['daterange']!,
  );

  DetailsRoute get _self => this as DetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/compass/${Uri.encodeComponent(_self.country)}/${Uri.encodeComponent(_self.destination)}/${Uri.encodeComponent(_self.activites)}/${Uri.encodeComponent(_self.daterange)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Continents)
const continentsProvider = ContinentsProvider._();

final class ContinentsProvider
    extends $AsyncNotifierProvider<Continents, List<String>> {
  const ContinentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'continentsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$continentsHash();

  @$internal
  @override
  Continents create() => Continents();
}

String _$continentsHash() => r'5b2a8c02346d6afb1bc1288aa0949395323e1f76';

abstract class _$Continents extends $AsyncNotifier<List<String>> {
  FutureOr<List<String>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<String>>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<String>>, List<String>>,
              AsyncValue<List<String>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CurrentContinent)
const currentContinentProvider = CurrentContinentProvider._();

final class CurrentContinentProvider
    extends $NotifierProvider<CurrentContinent, String> {
  const CurrentContinentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentContinentProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentContinentHash();

  @$internal
  @override
  CurrentContinent create() => CurrentContinent();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$currentContinentHash() => r'169ca082526fc94396c07fde525b82c17e615fab';

abstract class _$CurrentContinent extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CountryDestinations)
const countryDestinationsProvider = CountryDestinationsProvider._();

final class CountryDestinationsProvider
    extends $AsyncNotifierProvider<CountryDestinations, List<Destination>> {
  const CountryDestinationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countryDestinationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countryDestinationsHash();

  @$internal
  @override
  CountryDestinations create() => CountryDestinations();
}

String _$countryDestinationsHash() =>
    r'975840f3288e416d2c7b72265b99b5d3c3e29805';

abstract class _$CountryDestinations extends $AsyncNotifier<List<Destination>> {
  FutureOr<List<Destination>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<Destination>>, List<Destination>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Destination>>, List<Destination>>,
              AsyncValue<List<Destination>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CurrentDestination)
const currentDestinationProvider = CurrentDestinationProvider._();

final class CurrentDestinationProvider
    extends $NotifierProvider<CurrentDestination, String> {
  const CurrentDestinationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentDestinationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentDestinationHash();

  @$internal
  @override
  CurrentDestination create() => CurrentDestination();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$currentDestinationHash() =>
    r'38d2295698a986dbb1058e588db727dce748611b';

abstract class _$CurrentDestination extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DestinationActivities)
const destinationActivitiesProvider = DestinationActivitiesProvider._();

final class DestinationActivitiesProvider
    extends $AsyncNotifierProvider<DestinationActivities, List<Activity>> {
  const DestinationActivitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'destinationActivitiesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$destinationActivitiesHash();

  @$internal
  @override
  DestinationActivities create() => DestinationActivities();
}

String _$destinationActivitiesHash() =>
    r'16fab941f058aea6a9be2414ae29ee7afc7427ae';

abstract class _$DestinationActivities extends $AsyncNotifier<List<Activity>> {
  FutureOr<List<Activity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Activity>>, List<Activity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Activity>>, List<Activity>>,
              AsyncValue<List<Activity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(SelectedActivities)
const selectedActivitiesProvider = SelectedActivitiesProvider._();

final class SelectedActivitiesProvider
    extends $NotifierProvider<SelectedActivities, List<String>> {
  const SelectedActivitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedActivitiesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedActivitiesHash();

  @$internal
  @override
  SelectedActivities create() => SelectedActivities();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$selectedActivitiesHash() =>
    r'24594490aa295184d295df35f7c6336bd824a26b';

abstract class _$SelectedActivities extends $Notifier<List<String>> {
  List<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<String>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<String>, List<String>>,
              List<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(Destinations)
const destinationsProvider = DestinationsProvider._();

final class DestinationsProvider
    extends $AsyncNotifierProvider<Destinations, List<Destination>> {
  const DestinationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'destinationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$destinationsHash();

  @$internal
  @override
  Destinations create() => Destinations();
}

String _$destinationsHash() => r'414be64d1e6132639e92e6b9414c71d3d65ee6b7';

abstract class _$Destinations extends $AsyncNotifier<List<Destination>> {
  FutureOr<List<Destination>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<Destination>>, List<Destination>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Destination>>, List<Destination>>,
              AsyncValue<List<Destination>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(activities)
const activitiesProvider = ActivitiesProvider._();

final class ActivitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Activity>>,
          List<Activity>,
          FutureOr<List<Activity>>
        >
    with $FutureModifier<List<Activity>>, $FutureProvider<List<Activity>> {
  const ActivitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activitiesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activitiesHash();

  @$internal
  @override
  $FutureProviderElement<List<Activity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Activity>> create(Ref ref) {
    return activities(ref);
  }
}

String _$activitiesHash() => r'8e5bc45cb867ddfb6d1eb0123689f7cd02ec4dfb';

@ProviderFor(TravelClient)
const travelClientProvider = TravelClientProvider._();

final class TravelClientProvider
    extends $NotifierProvider<TravelClient, protoclient.TravelServiceClient> {
  const TravelClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'travelClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$travelClientHash();

  @$internal
  @override
  TravelClient create() => TravelClient();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(protoclient.TravelServiceClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<protoclient.TravelServiceClient>(
        value,
      ),
    );
  }
}

String _$travelClientHash() => r'e2392e744224421d161507177da5b1c50da55bf0';

abstract class _$TravelClient
    extends $Notifier<protoclient.TravelServiceClient> {
  protoclient.TravelServiceClient build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              protoclient.TravelServiceClient,
              protoclient.TravelServiceClient
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                protoclient.TravelServiceClient,
                protoclient.TravelServiceClient
              >,
              protoclient.TravelServiceClient,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
