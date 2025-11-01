import 'package:example/carousel/carouselmain.dart';
import 'package:example/main.dart';
import 'package:example/pages/compass.dart';
import 'package:example/pages/funko.dart';
import 'package:example/pages/manager.dart';
import 'package:example/pages/music.dart';
import 'package:example/pages/node_editor.dart';
import 'package:example/pages/quiz.dart';
import 'package:example/pages/rankone.dart';
import 'package:example/pages/recipe.dart';
import 'package:example/pages/travel.dart';
import 'package:go_router/go_router.dart';

List<RouteBase> getAppRoutes() => [
  GoRoute(
    path: "/",
    builder: (context, state) {
      return Home();
    },
  ),
  GoRoute(
    path: "/carousel",
    builder: (context, state) {
      return Carouselmain();
    },
  ),
  GoRoute(
    path: "/quiz",
    builder: (context, state) {
      return Quiz();
    },
  ),
  GoRoute(
    path: "/manager",
    builder: (context, state) {
      return ManagerApp();
    },
  ),
  GoRoute(
    path: "/recipe",
    builder: (context, state) {
      return RecipeApp();
    },
  ),
  ...compassRoutes,
  GoRoute(
    path: "/music",
    builder: (context, state) {
      return MusicApp();
    },
  ),
  GoRoute(
    path: "/games",
    builder: (context, state) {
      return GamesApp();
    },
  ),
  GoRoute(
    path: "/funko",
    builder: (context, state) {
      return FunkoApp();
    },
  ),
  GoRoute(
    path: "/travel",
    builder: (context, state) {
      return TravelApp();
    },
  ),
  GoRoute(
    path: "/node_editor",
    builder: (context, state) {
      return NodeEditorScaffold();
    },
  ),
];
