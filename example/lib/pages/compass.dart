import 'package:example/pages/travel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moonspace/form/sherlock.dart';
import 'package:moonspace/carousel/curved_carousel.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

import 'package:connectrpc/http2.dart';
import 'package:connectrpc/protobuf.dart';
import 'package:connectrpc/protocol/connect.dart' as protocol;
import 'package:example/proto/v1/data.connect.client.dart' as protoclient;
import 'package:example/proto/v1/data.pbserver.dart' as proto;

part 'compass.g.dart';

List<RouteBase> get compassRoutes => $appRoutes;

@TypedGoRoute<CountriesRoute>(
  path: '/compass',
  routes: [
    TypedGoRoute<CountryRoute>(
      path: ':country',
      routes: [
        TypedGoRoute<ActivitiesRoute>(
          path: ':destination',
          routes: [TypedGoRoute<DetailsRoute>(path: ':activites/:daterange')],
        ),
      ],
    ),
  ],
)
class CountriesRoute extends GoRouteData with $CountriesRoute {
  const CountriesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Consumer(
      builder: (context, ref, child) {
        final asyncContinents = ref.watch(continentsProvider);

        return Scaffold(
          appBar: CompassAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Sherlock<Destination>(
                    onFetch: (query) async {
                      return ref
                          .read(travelClientProvider.notifier)
                          .searchDestination(query);
                    },
                    builder: (data, controller) {
                      return ListView(
                        shrinkWrap: true,
                        children: data
                            .map(
                              (d) => ListTile(
                                title: Text(d.name),
                                subtitle: Text(d.country),
                                onTap: () {
                                  ref
                                      .read(currentDestinationProvider.notifier)
                                      .setDestination(d.ref);
                                  ActivitiesRoute(
                                    d.country,
                                    d.ref,
                                  ).push(context);
                                },
                              ),
                            )
                            .toList(),
                      );
                    },
                    bar: true,
                    hint: "Search destinations?",
                  ),

                  const SizedBox(height: 16),

                  ClipRRect(
                    child: asyncContinents.when(
                      data: (continents) {
                        if (continents.isEmpty) return const SizedBox();

                        return CurvedCarousel(
                          height: 150,
                          // width: context.mq.w,
                          rotationMultiplier: 0,
                          xMultiplier: 2.2,
                          yMultiplier: 0,
                          opacityMin: 1,
                          scaleMin: 1,
                          alignment: Alignment.centerLeft,
                          count: continents.length,
                          onSelectedItemChanged: (index) {
                            print(index);
                          },
                          staticBuilder: (index) {
                            return SizedBox(
                              key: ValueKey(index),
                              width: 140,
                              child: GestureDetector(
                                onTap: () {
                                  final continent = continents[index];
                                  print("$index $continent");
                                  ref
                                      .read(currentContinentProvider.notifier)
                                      .setContinent(continent);
                                  CountryRoute(continent).push(context);
                                },
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    SizedBox(
                                      width: 140,
                                      child: Hero(
                                        tag: 'continent-$index-image',
                                        child: CustomCacheImage(
                                          imageUrl:
                                              images[index % images.length],
                                          borderRadius: 24,
                                        ),
                                      ),
                                    ),

                                    Hero(
                                      tag: 'continent-$index-title',
                                      child: Text(
                                        '$index + ${continents[index]}',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.agbalumo(
                                          textStyle: context.h4.c(Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Text('Error: $error'),
                    ),
                  ),

                  const SizedBox(height: 16),

                  ListTile(
                    onTap: () async {
                      await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                    },
                    title: Text("When"),
                  ),

                  ListTile(onTap: () async {}, title: Text("Who")),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CountryRoute extends GoRouteData with $CountryRoute {
  const CountryRoute(this.country);

  final String country;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Consumer(
      builder: (context, ref, child) {
        final currentDestinations = ref.watch(countryDestinationsProvider);

        return Scaffold(
          appBar: CompassAppBar(),
          body: currentDestinations.when(
            data: (data) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: .85,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(currentDestinationProvider.notifier)
                            .setDestination(data[index].ref);
                        ActivitiesRoute(country, data[index].ref).push(context);
                      },
                      child: Stack(
                        children: [
                          Hero(
                            tag: 'country-$index-image',
                            child: CustomCacheImage(
                              imageUrl: data[index].imageUrl,
                              borderRadius: 8,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].country,
                                  style: context.h8.w6.c(Colors.white),
                                ),
                                Spacer(),
                                Text(
                                  data[index].name,
                                  style: context.h8.w6.c(Colors.white),
                                ),
                                Wrap(
                                  runSpacing: 4,
                                  spacing: 4,
                                  children: data[index].tags.map((tag) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                          82,
                                          47,
                                          47,
                                          47,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        tag,
                                        style: context.ls.c(Colors.white),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text('Error: $error'),
          ),
        );
      },
    );
  }
}

class ActivitiesRoute extends GoRouteData with $ActivitiesRoute {
  const ActivitiesRoute(this.country, this.destination);

  final String country;
  final String destination;

  Widget tile(
    BuildContext context,
    WidgetRef ref,
    Activity activity,
    List<String> selected,
  ) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedActivitiesProvider.notifier).toggleActivity(activity);
      },
      child: ActivityTile(
        activity: activity,
        selected: selected.contains(activity.ref),
      ),
    );
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Consumer(
      builder: (context, ref, child) {
        final asyncActivites = ref.watch(destinationActivitiesProvider);
        final selected = ref.watch(selectedActivitiesProvider);

        return PopScope(
          onPopInvokedWithResult: (didPop, result) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(selectedActivitiesProvider.notifier).clear();
            });
          },
          child: Scaffold(
            bottomNavigationBar: BottomAppBar(
              padding: EdgeInsets.all(16),
              height: 70,
              child: Row(
                children: <Widget>[
                  Text("${selected.length} selected", style: context.h7),
                  Spacer(),
                  FilledButton.tonal(
                    onPressed: () {
                      DetailsRoute(
                        country,
                        destination,
                        selected.join(","),
                        "${DateTime(2022).toString()},${DateTime(2023).toString()}",
                      ).push(context);
                    },
                    child: Text("Confirm"),
                  ),
                ],
              ),
            ),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: Icon(CupertinoIcons.arrow_left),
                      ),
                      Text(
                        "Activites",
                        style: GoogleFonts.robotoMono(textStyle: context.h5),
                      ),
                      IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: Icon(CupertinoIcons.home),
                      ),
                    ],
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Daytime",
                      style: GoogleFonts.robotoMono(textStyle: context.h7),
                    ),
                  ),
                ),

                asyncActivites.when(
                  data: (activities) {
                    return SliverList.list(
                      children: activities
                          .where(
                            (a) =>
                                a.timeOfDay == "morning" ||
                                a.timeOfDay == "afternoon" ||
                                a.timeOfDay == "any",
                          )
                          .map((a) => tile(context, ref, a, selected))
                          .toList(),
                    );
                  },
                  error: (error, stackTrace) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text(error.toString())),
                    );
                  },
                  loading: () {
                    return SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Night",
                      style: GoogleFonts.robotoMono(textStyle: context.h7),
                    ),
                  ),
                ),

                asyncActivites.when(
                  data: (activities) {
                    return SliverList.list(
                      children: activities
                          .where(
                            (a) =>
                                !(a.timeOfDay == "morning" ||
                                    a.timeOfDay == "afternoon" ||
                                    a.timeOfDay == "any"),
                          )
                          .map((a) => tile(context, ref, a, selected))
                          .toList(),
                    );
                  },
                  error: (error, stackTrace) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text(error.toString())),
                    );
                  },
                  loading: () {
                    return SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ActivityTile extends StatelessWidget {
  const ActivityTile({
    super.key,
    required this.activity,
    required this.selected,
  });

  final Activity activity;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: selected ? context.cSur2 : context.cSur,
      padding: const EdgeInsets.all(8.0),
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12),
            child: SizedBox(
              width: 75,
              height: 75,
              child: CustomCacheImage(imageUrl: activity.imageUrl),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(activity.timeOfDay.toUpperCase(), style: context.ls),
                  Text(
                    activity.name,
                    overflow: TextOverflow.clip,
                    style: context.h8,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Icon(
              selected ? CupertinoIcons.circle_fill : CupertinoIcons.circle,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsRoute extends GoRouteData with $DetailsRoute {
  const DetailsRoute(
    this.country,
    this.destination,
    this.activites,
    this.daterange,
  );

  final String country;
  final String destination;

  final String activites;
  final String daterange;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedActivities = activites.split(",").toList();

        return Consumer(
          builder: (context, ref, child) {
            final asyncDestination = ref.watch(destinationsProvider);
            final asyncActivites = ref.watch(activitiesProvider);

            if (asyncDestination.hasValue && asyncActivites.hasValue) {
              final destinations = asyncDestination.value ?? [];
              final activityList = asyncActivites.value ?? [];

              final des = destinations.firstWhere((e) => e.ref == destination);

              return Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      collapsedHeight: 180,
                      flexibleSpace: CustomCacheImage(imageUrl: des.imageUrl),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(des.name), Text(des.knownFor)],
                      ),
                    ),
                    SliverList.list(
                      children:
                          (activityList.where(
                                (e) => selectedActivities.contains(e.ref),
                              ))
                              .map(
                                (e) =>
                                    ActivityTile(activity: e, selected: true),
                              )
                              .toList(),
                    ),
                  ],
                ),
              );
            } else {
              return Scaffold(
                appBar: CompassAppBar(),
                body: CircularProgressIndicator(),
              );
            }
          },
        );
      },
    );
  }
}

class CompassAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CompassAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(CupertinoIcons.arrow_left),
      ),
      title: Text(GoRouterState.of(context).uri.path),
      actions: [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

@Riverpod(keepAlive: true)
class Continents extends _$Continents {
  @override
  FutureOr<List<String>> build() async {
    final asyncDestinations = ref.watch(destinationsProvider);
    final destinations = asyncDestinations.asData?.value;
    final uniqueContinents = destinations
        ?.map((destination) => destination.continent)
        .toSet()
        .toList();

    return uniqueContinents ?? [];
  }

  FutureOr<List<Destination>> getDestinationsInContinent(
    String continent,
  ) async {
    final asyncDestinations = ref.read(destinationsProvider);
    final destinations = asyncDestinations.asData?.value;
    final uniqueDestinations = destinations
        ?.where((destination) => destination.continent == continent)
        .toSet()
        .toList();

    return uniqueDestinations ?? [];
  }
}

@Riverpod(keepAlive: true)
class CurrentContinent extends _$CurrentContinent {
  @override
  String build() {
    return "";
  }

  void setContinent(String continent) {
    state = continent;
  }
}

@Riverpod(keepAlive: true)
class CountryDestinations extends _$CountryDestinations {
  @override
  FutureOr<List<Destination>> build() async {
    final asyncDestinations = ref.watch(destinationsProvider);
    final continent = ref.watch(currentContinentProvider);
    final destinations = asyncDestinations.asData?.value;
    final uniqueContinents = destinations
        ?.where((destination) => destination.continent == continent)
        .toSet()
        .toList();

    return uniqueContinents ?? [];
  }
}

@Riverpod(keepAlive: true)
class CurrentDestination extends _$CurrentDestination {
  @override
  String build() {
    return "";
  }

  void setDestination(String destination) {
    state = destination;
  }
}

@Riverpod(keepAlive: true)
class DestinationActivities extends _$DestinationActivities {
  @override
  FutureOr<List<Activity>> build() async {
    final destination = ref.watch(currentDestinationProvider);
    final asyncActivities = ref.watch(activitiesProvider);
    final activities = asyncActivities.asData?.value;
    final uniqueActivities = activities
        ?.where((activity) => activity.destinationRef == destination)
        .toSet()
        .toList();

    return uniqueActivities ?? [];
  }
}

@Riverpod(keepAlive: true)
class SelectedActivities extends _$SelectedActivities {
  @override
  List<String> build() {
    return [];
  }

  void toggleActivity(Activity a) {
    final currentState = List<String>.from(
      state,
    ); // Create a copy of the current state
    if (currentState.contains(a.ref)) {
      currentState.remove(a.ref);
    } else {
      currentState.add(a.ref);
    }
    state = currentState;
  }

  void clear() {
    state = [];
  }
}

class Destination {
  final String ref;
  final String name;
  final String country;
  final String continent;
  final String knownFor;
  final List<String> tags;
  final String imageUrl;

  Destination({
    required this.ref,
    required this.name,
    required this.country,
    required this.continent,
    required this.knownFor,
    required this.tags,
    required this.imageUrl,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      ref: json['ref'],
      name: json['name'],
      country: json['country'],
      continent: json['continent'],
      knownFor: json['knownFor'],
      tags: List<String>.from(json['tags']),
      imageUrl: json['imageUrl'],
    );
  }

  factory Destination.fromProto(proto.Destination d) {
    return Destination(
      ref: d.ref,
      name: d.name,
      country: d.country,
      continent: d.continent,
      knownFor: d.knownFor,
      tags: d.tags,
      imageUrl: d.imageUrl,
    );
  }
}

@Riverpod(keepAlive: true)
class Destinations extends _$Destinations {
  @override
  FutureOr<List<Destination>> build() async {
    final String response = await rootBundle.loadString(
      'assets/destinations.json',
    );
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Destination.fromJson(json)).toList();
  }
}

class Activity {
  final String name;
  final String description;
  final String locationName;
  final int duration; // in hours
  final String timeOfDay;
  final bool familyFriendly;
  final int price; // price level (1-5)
  final String destinationRef;
  final String ref;
  final String imageUrl;

  Activity({
    required this.name,
    required this.description,
    required this.locationName,
    required this.duration,
    required this.timeOfDay,
    required this.familyFriendly,
    required this.price,
    required this.destinationRef,
    required this.ref,
    required this.imageUrl,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      name: json['name'],
      description: json['description'],
      locationName: json['locationName'],
      duration: (json['duration'] as num).toInt(), // Convert to int
      timeOfDay: json['timeOfDay'],
      familyFriendly: json['familyFriendly'],
      price: (json['price'] as num).toInt(), // Convert to int
      destinationRef: json['destinationRef'],
      ref: json['ref'],
      imageUrl: json['imageUrl'],
    );
  }

  factory Activity.fromProto(proto.Activity a) {
    return Activity(
      name: a.name,
      description: a.description,
      locationName: a.locationName,
      duration: a.duration.toInt(),
      timeOfDay: a.timeOfDay,
      familyFriendly: a.familyFriendly,
      price: a.price.toInt(),
      destinationRef: a.destinationRef,
      ref: a.ref,
      imageUrl: a.imageUrl,
    );
  }
}

@Riverpod(keepAlive: true)
FutureOr<List<Activity>> activities(Ref ref) async {
  final String response = await rootBundle.loadString('assets/activities.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => Activity.fromJson(json)).toList();
}

@Riverpod(keepAlive: true)
class TravelClient extends _$TravelClient {
  protoclient.TravelServiceClient get client => state;
  @override
  protoclient.TravelServiceClient build() {
    final transport = protocol.Transport(
      baseUrl: "http://localhost:8080",
      codec: const ProtoCodec(),
      httpClient: createHttpClient(),
    );

    final travelClient = protoclient.TravelServiceClient(transport);

    return travelClient;
  }

  Future<Destination> getDestination(String name) async {
    try {
      final response = await client.getDestination(
        proto.GetDestinationRequest(ref: name),
      );
      return Destination.fromProto(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Destination>> searchDestination(String name) async {
    try {
      final response = await client.searchDestinations(
        proto.GetDestinationRequest(ref: name),
      );
      return response.destinations
          .map((d) => Destination.fromProto(d))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
