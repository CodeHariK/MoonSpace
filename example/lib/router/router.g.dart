// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$rootRoute];

RouteBase get $rootRoute => GoRouteData.$route(
  path: '/',
  factory: $RootRoute._fromState,
  routes: [
    GoRouteData.$route(path: 'extra', factory: $ExtraRoute._fromState),
    GoRouteData.$route(
      path: 'enum/:requiredEnumField',
      factory: $EnumRoute._fromState,
    ),
    ShellRouteData.$route(
      navigatorKey: MyShellRouteData.$navigatorKey,
      factory: $MyShellRouteDataExtension._fromState,
      routes: [
        GoRouteData.$route(path: 'foo', factory: $FooRouteData._fromState),
        GoRouteData.$route(
          path: 'users',
          factory: $UsersRouteData._fromState,
          routes: [
            GoRouteData.$route(
              path: ':id',
              parentNavigatorKey: UserRouteData.$parentNavigatorKey,
              factory: $UserRouteData._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellRouteData.$route(
      restorationScopeId: MyStatefulShellRouteData.$restorationScopeId,
      navigatorContainerBuilder:
          MyStatefulShellRouteData.$navigatorContainerBuilder,
      factory: $MyStatefulShellRouteDataExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: 'detailsA',
              factory: $DetailsARouteData._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          navigatorKey: BranchBData.$navigatorKey,
          restorationScopeId: BranchBData.$restorationScopeId,
          routes: [
            GoRouteData.$route(
              path: 'detailsB',
              factory: $DetailsBRouteData._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellRouteData.$route(
      factory: $MainShellRouteDataExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          initialLocation: NotificationsShellBranchData.$initialLocation,
          routes: [
            GoRouteData.$route(
              path: '/notifications/:section',
              factory: $NotificationsRouteData._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/orders',
              factory: $OrdersRouteData._fromState,
            ),
          ],
        ),
      ],
    ),
  ],
);

mixin $RootRoute on GoRouteData {
  static RootRoute _fromState(GoRouterState state) => const RootRoute();

  @override
  String get location => GoRouteData.$location('/');

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

mixin $ExtraRoute on GoRouteData {
  static ExtraRoute _fromState(GoRouterState state) =>
      ExtraRoute($extra: state.extra as Extra?);

  ExtraRoute get _self => this as ExtraRoute;

  @override
  String get location => GoRouteData.$location('/extra');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $EnumRoute on GoRouteData {
  static EnumRoute _fromState(GoRouterState state) => EnumRoute(
    requiredEnumField: _$SportDetailsEnumMap._$fromName(
      state.pathParameters['requiredEnumField']!,
    )!,
    enumField: _$convertMapValue(
      'enum-field',
      state.uri.queryParameters,
      _$SportDetailsEnumMap._$fromName,
    ),
    enumFieldWithDefaultValue:
        _$convertMapValue(
          'enum-field-with-default-value',
          state.uri.queryParameters,
          _$SportDetailsEnumMap._$fromName,
        ) ??
        SportDetails.football,
  );

  EnumRoute get _self => this as EnumRoute;

  @override
  String get location => GoRouteData.$location(
    '/enum/${Uri.encodeComponent(_$SportDetailsEnumMap[_self.requiredEnumField]!)}',
    queryParams: {
      if (_self.enumField != null)
        'enum-field': _$SportDetailsEnumMap[_self.enumField!],
      if (_self.enumFieldWithDefaultValue != SportDetails.football)
        'enum-field-with-default-value':
            _$SportDetailsEnumMap[_self.enumFieldWithDefaultValue],
    },
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

const _$SportDetailsEnumMap = {
  SportDetails.volleyball: 'volleyball',
  SportDetails.football: 'football',
  SportDetails.tennis: 'tennis',
  SportDetails.hockey: 'hockey',
};

extension $MyShellRouteDataExtension on MyShellRouteData {
  static MyShellRouteData _fromState(GoRouterState state) =>
      const MyShellRouteData();
}

mixin $FooRouteData on GoRouteData {
  static FooRouteData _fromState(GoRouterState state) => const FooRouteData();

  @override
  String get location => GoRouteData.$location('/foo');

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

mixin $UsersRouteData on GoRouteData {
  static UsersRouteData _fromState(GoRouterState state) =>
      const UsersRouteData();

  @override
  String get location => GoRouteData.$location('/users');

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

mixin $UserRouteData on GoRouteData {
  static UserRouteData _fromState(GoRouterState state) =>
      UserRouteData(id: int.parse(state.pathParameters['id']!));

  UserRouteData get _self => this as UserRouteData;

  @override
  String get location => GoRouteData.$location(
    '/users/${Uri.encodeComponent(_self.id.toString())}',
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

extension $MyStatefulShellRouteDataExtension on MyStatefulShellRouteData {
  static MyStatefulShellRouteData _fromState(GoRouterState state) =>
      const MyStatefulShellRouteData();
}

mixin $DetailsARouteData on GoRouteData {
  static DetailsARouteData _fromState(GoRouterState state) =>
      const DetailsARouteData();

  @override
  String get location => GoRouteData.$location('/detailsA');

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

mixin $DetailsBRouteData on GoRouteData {
  static DetailsBRouteData _fromState(GoRouterState state) =>
      const DetailsBRouteData();

  @override
  String get location => GoRouteData.$location('/detailsB');

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

extension $MainShellRouteDataExtension on MainShellRouteData {
  static MainShellRouteData _fromState(GoRouterState state) =>
      const MainShellRouteData();
}

mixin $NotificationsRouteData on GoRouteData {
  static NotificationsRouteData _fromState(GoRouterState state) =>
      NotificationsRouteData(
        section: _$NotificationsPageSectionEnumMap._$fromName(
          state.pathParameters['section']!,
        )!,
      );

  NotificationsRouteData get _self => this as NotificationsRouteData;

  @override
  String get location => GoRouteData.$location(
    '/notifications/${Uri.encodeComponent(_$NotificationsPageSectionEnumMap[_self.section]!)}',
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

const _$NotificationsPageSectionEnumMap = {
  NotificationsPageSection.latest: 'latest',
  NotificationsPageSection.old: 'old',
  NotificationsPageSection.archive: 'archive',
};

mixin $OrdersRouteData on GoRouteData {
  static OrdersRouteData _fromState(GoRouterState state) =>
      const OrdersRouteData();

  @override
  String get location => GoRouteData.$location('/orders');

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

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T? Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

extension<T extends Enum> on Map<T, String> {
  T? _$fromName(String? value) =>
      entries.where((element) => element.value == value).firstOrNull?.key;
}
