import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moonspace/router/router.dart';
import './data.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  routes: $appRoutes,
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
);

class GoRouterApp extends StatelessWidget {
  const GoRouterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}

@TypedGoRoute<RootRoute>(
  path: '/',
  routes: [
    TypedGoRoute<ExtraRoute>(path: 'extra'),
    TypedGoRoute<EnumRoute>(path: 'enum/:requiredEnumField'),

    TypedShellRoute<MyShellRouteData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<FooRouteData>(path: 'foo'),
        TypedGoRoute<UsersRouteData>(
          path: 'users',
          routes: <TypedGoRoute<UserRouteData>>[
            TypedGoRoute<UserRouteData>(path: ':id'),
          ],
        ),
      ],
    ),

    TypedStatefulShellRoute<MyStatefulShellRouteData>(
      branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
        TypedStatefulShellBranch<BranchAData>(
          routes: <TypedRoute<RouteData>>[
            TypedGoRoute<DetailsARouteData>(path: 'detailsA'),
          ],
        ),
        TypedStatefulShellBranch<BranchBData>(
          routes: <TypedRoute<RouteData>>[
            TypedGoRoute<DetailsBRouteData>(path: 'detailsB'),
          ],
        ),
      ],
    ),

    TypedStatefulShellRoute<MainShellRouteData>(
      branches: [
        TypedStatefulShellBranch<NotificationsShellBranchData>(
          routes: [
            TypedGoRoute<NotificationsRouteData>(
              path: '/notifications/:section',
            ),
          ],
        ),
        TypedStatefulShellBranch<OrdersShellBranchData>(
          routes: [TypedGoRoute<OrdersRouteData>(path: '/orders')],
        ),
      ],
    ),
  ],
)
class RootRoute extends GoRouteData with $RootRoute {
  const RootRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => Scaffold(
    appBar: AppBar(title: Text(GoRouterState.of(context).uri.path)),
    body: ListView(
      children: <Widget>[
        ListTile(
          onTap: () => const ExtraRoute($extra: Extra(2)).go(context),
          title: const Text('Optional Extra'),
        ),
        ListTile(
          onTap: () => const FooRouteData().go(context),
          title: const Text('FooRouteData'),
        ),
        ListTile(
          onTap: () => const UsersRouteData().go(context),
          title: const Text('UsersRouteData'),
        ),
        ListTile(
          onTap: () => const DetailsARouteData().go(context),
          title: const Text('DetailsARouteData'),
        ),
        ListTile(
          onTap: () => const OrdersRouteData().go(context),
          title: const Text('OrdersRouteData'),
        ),
        EnumRoute(
          requiredEnumField: SportDetails.football,
          enumField: SportDetails.volleyball,
          enumFieldWithDefaultValue: SportDetails.hockey,
        ).drawerTile(context),
      ],
    ),
  );
}

class Extra {
  const Extra(this.value);

  final int value;
}

class ExtraRoute extends GoRouteData with $ExtraRoute {
  const ExtraRoute({this.$extra});

  final Extra? $extra;

  @override
  Future<bool> onExit(BuildContext context, GoRouterState state) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        content: const Text('Are you sure to leave this page?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) => Scaffold(
    appBar: AppBar(
      leading: BackButton(),
      title: Text(GoRouterState.of(context).uri.path),
    ),
    body: Center(child: Text('Extra: ${$extra?.value}')),
  );
}

class EnumRoute extends GoRouteData with $EnumRoute {
  EnumRoute({
    required this.requiredEnumField,
    this.enumField,
    this.enumFieldWithDefaultValue = SportDetails.football,
  });

  final SportDetails requiredEnumField;
  final SportDetails? enumField;
  final SportDetails enumFieldWithDefaultValue;

  @override
  Widget build(BuildContext context, GoRouterState state) => Scaffold(
    appBar: AppBar(title: Text(GoRouterState.of(context).uri.path)),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Param: $requiredEnumField'),
          Text('Query param: $enumField'),
          Text('Query param with default value: $enumFieldWithDefaultValue'),
          SelectableText(GoRouterState.of(context).uri.path),
          SelectableText(
            GoRouterState.of(context).uri.queryParameters.toString(),
          ),
        ],
      ),
    ),
  );

  Widget drawerTile(BuildContext context) => ListTile(
    title: const Text('EnhancedEnumRoute'),
    onTap: () => go(context),
    selected: GoRouterState.of(context).uri.path == location,
  );
}

////
////
////
////
////
////

class MyShellRouteData extends ShellRouteData {
  const MyShellRouteData();

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return MyShellRouteScreen(child: navigator);
  }
}

class FooRouteData extends GoRouteData with $FooRouteData {
  const FooRouteData();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return fadePage(context, state, Text("Foo"));
  }
}

class MyShellRouteScreen extends StatelessWidget {
  const MyShellRouteScreen({required this.child, super.key});

  final Widget child;

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location == '/bar') {
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final int currentIndex = getCurrentIndex(context);
    return Scaffold(
      appBar: AppBar(title: Text(GoRouterState.of(context).uri.path)),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Foo'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Users'),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              const FooRouteData().go(context);
            case 1:
              const UsersRouteData().go(context);
          }
        },
      ),
    );
  }
}

class UsersRouteData extends GoRouteData with $UsersRouteData {
  const UsersRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          for (int userID = 1; userID <= 3; userID++)
            ListTile(
              title: Text('User $userID'),
              onTap: () async {
                final u = await UserRouteData(id: userID).push<String>(context);
                print(u);
              },
            ),
        ],
      ),
    );
  }
}

class DialogPage extends Page<String> {
  /// A page to display a dialog.
  const DialogPage({required this.child, super.key});

  /// The widget to be displayed which is usually a [Dialog] widget.
  final Widget child;

  @override
  Route<String> createRoute(BuildContext context) {
    return DialogRoute<String>(
      context: context,
      settings: this,
      builder: (BuildContext context) => child,
    );
  }
}

class UserRouteData extends GoRouteData with $UserRouteData {
  const UserRouteData({required this.id});

  // Without this static key, the dialog will not cover the navigation rail.
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  final int id;

  @override
  Page<String> buildPage(BuildContext context, GoRouterState state) {
    return DialogPage(
      key: state.pageKey,
      child: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Card(
            child: Center(
              child: TextButton(
                onPressed: () {
                  context.pop("Hello");
                },
                child: Text('User $id'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///
///
///
///
///
///

final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

class MyStatefulShellRouteData extends StatefulShellRouteData {
  const MyStatefulShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return navigationShell;
  }

  static const String $restorationScopeId = 'restorationScopeId';

  static Widget $navigatorContainerBuilder(
    BuildContext context,
    StatefulNavigationShell navigationShell,
    List<Widget> children,
  ) {
    return ScaffoldWithNavBar(
      navigationShell: navigationShell,
      children: children,
    );
  }
}

class BranchAData extends StatefulShellBranchData {
  const BranchAData();
}

class BranchBData extends StatefulShellBranchData {
  const BranchBData();

  static final GlobalKey<NavigatorState> $navigatorKey = _sectionANavigatorKey;
  static const String $restorationScopeId = 'restorationScopeId';
}

class DetailsARouteData extends GoRouteData with $DetailsARouteData {
  const DetailsARouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DetailsScreen(label: 'A');
  }
}

class DetailsBRouteData extends GoRouteData with $DetailsBRouteData {
  const DetailsBRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DetailsScreen(label: 'B');
  }
}

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell,
    required this.children,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  /// The children (branch Navigators) to display in a custom container
  /// ([AnimatedBranchContainer]).
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBranchContainer(
        currentIndex: navigationShell.currentIndex,
        children: children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // Here, the items of BottomNavigationBar are hard coded. In a real
        // world scenario, the items would most likely be generated from the
        // branches of the shell route, which can be fetched using
        // `navigationShell.route.branches`.
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Section A'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Section B'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

/// Custom branch Navigator container that provides animated transitions
/// when switching branches.
class AnimatedBranchContainer extends StatelessWidget {
  /// Creates a AnimatedBranchContainer
  const AnimatedBranchContainer({
    super.key,
    required this.currentIndex,
    required this.children,
  });

  /// The index (in [children]) of the branch Navigator to display.
  final int currentIndex;

  /// The children (branch Navigators) to display in this container.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: children.asMap().entries.map((o) {
        return AnimatedScale(
          scale: o.key == currentIndex ? 1 : 1.5,
          duration: const Duration(milliseconds: 400),
          child: AnimatedOpacity(
            opacity: o.key == currentIndex ? 1 : 0,
            duration: const Duration(milliseconds: 400),
            child: _branchNavigatorWrapper(o.key, o.value),
          ),
        );
      }).toList(),
    );
  }

  Widget _branchNavigatorWrapper(int index, Widget navigator) => IgnorePointer(
    ignoring: index != currentIndex,
    child: TickerMode(enabled: index == currentIndex, child: navigator),
  );
}

/// The details screen for either the A or B screen.
class DetailsScreen extends StatefulWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({required this.label, this.param, this.extra, super.key});

  /// The label to display in the center of the screen.
  final String label;

  /// Optional param
  final String? param;

  /// Optional extra object
  final Object? extra;
  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

/// The state for DetailsScreen
class DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details Screen - ${widget.label}')),
      body: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Details for ${widget.label} - Counter: $_counter',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Padding(padding: EdgeInsets.all(4)),
          TextButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            child: const Text('Increment counter'),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          if (widget.param != null)
            Text(
              'Parameter: ${widget.param!}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          const Padding(padding: EdgeInsets.all(8)),
          if (widget.extra != null)
            Text(
              'Extra: ${widget.extra!}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
        ],
      ),
    );
  }
}

////
////
////
////
////
////

class MainShellRouteData extends StatefulShellRouteData {
  const MainShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return MainPageView(navigationShell: navigationShell);
  }
}

class NotificationsShellBranchData extends StatefulShellBranchData {
  const NotificationsShellBranchData();

  static String $initialLocation = '/notifications/old';
}

class OrdersShellBranchData extends StatefulShellBranchData {
  const OrdersShellBranchData();
}

enum NotificationsPageSection { latest, old, archive }

class NotificationsRouteData extends GoRouteData with $NotificationsRouteData {
  const NotificationsRouteData({required this.section});

  final NotificationsPageSection section;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NotificationsPageView(section: section);
  }
}

class OrdersRouteData extends GoRouteData with $OrdersRouteData {
  const OrdersRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Text('Orders page');
  }
}

class MainPageView extends StatelessWidget {
  const MainPageView({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Orders'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class NotificationsPageView extends StatelessWidget {
  const NotificationsPageView({super.key, required this.section});

  final NotificationsPageSection section;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: NotificationsPageSection.values.indexOf(section),
      child: const Column(
        children: <Widget>[
          TabBar(
            tabs: <Tab>[
              Tab(
                child: Text('Latest', style: TextStyle(color: Colors.black87)),
              ),
              Tab(
                child: Text('Old', style: TextStyle(color: Colors.black87)),
              ),
              Tab(
                child: Text('Archive', style: TextStyle(color: Colors.black87)),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                Text('Latest notifications'),
                Text('Old notifications'),
                Text('Archived notifications'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
