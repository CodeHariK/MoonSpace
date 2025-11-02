import 'package:example/app_routes.dart';
import 'package:example/app_themes.dart';
import 'package:example/basic/bar.dart';
import 'package:example/basic/button.dart';
import 'package:example/basic/color.dart';
import 'package:example/basic/dialog.dart';
import 'package:example/basic/dropdown.dart';
import 'package:example/basic/input.dart';
import 'package:example/basic/nav.dart';
import 'package:example/basic/selector.dart';
import 'package:example/basic/typography.dart';
import 'package:example/carousel/carouselmain.dart';
import 'package:example/l10n/app_localizations.dart';
import 'package:example/pages/compass.dart';
import 'package:example/pages/funko.dart';
import 'package:example/pages/manager.dart';
import 'package:example/pages/music.dart';
import 'package:example/pages/node_editor.dart';
import 'package:example/pages/quiz.dart';
import 'package:example/pages/rankone.dart';
import 'package:example/pages/recipe.dart';
import 'package:example/router/router.dart';
import 'package:example/smooth_sheets/main.dart';
import 'package:example/pages/travel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonspace/electrify.dart';
import 'package:moonspace/form/select.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';
import 'package:moonspace/provider/global_theme.dart';
import 'package:moonspace/theme.dart';
import 'package:moonspace/widgets/functions.dart';

import 'package:moonspace/widgets/animated/neon_button.dart';

import 'package:moon_debug/moon_debug_wrapper.dart';

void main() {
  // runApp(const GoRouterApp());
  // runApp(const SmoothSheetApp());

  // runApp(ScreenshotApp());

  // return;

  final initialLocation = '/';

  electrify(
    title: "Home",
    before: (widgetsBinding) {},
    after: () {},
    wrap: (context, child) {
      return MoonDebugWrapper(
        paths: [
          MoonDrawerLink(label: "Home", path: '/'),
          MoonDrawerLink(label: "Compass", path: '/compass'),
          MoonDrawerLink(label: "Quiz", path: '/quiz'),
          MoonDrawerLink(label: "Manager", path: '/manager'),
          MoonDrawerLink(label: "Recipe", path: '/recipe'),
          MoonDrawerLink(label: "Games", path: '/games'),
          MoonDrawerLink(label: "Funko", path: '/funko'),
          MoonDrawerLink(label: "Travel", path: '/travel'),
          MoonDrawerLink(label: "Node Editor", path: '/node_editor'),
          MoonDrawerLink(label: "Music", path: '/music'),
          MoonDrawerLink(label: "Carousel", path: '/carousel'),
          MoonDrawerLink(label: "ColorScheme", child: ColorSchemeExample()),
        ],
        child: child ?? Text("Error"),
      );
    },
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    themes: getAppThemes(),
    router: (navigatorKey) => GoRouter(
      navigatorKey: navigatorKey,
      debugLogDiagnostics: true,
      initialLocation: initialLocation,
      errorPageBuilder: (context, state) {
        return MaterialPage(child: Scaffold(body: Text(state.error.toString())));
      },
      routes: getAppRoutes(),
    ),
    init: (c) async {},
    recordFlutterFatalError: (details) {},
    recordError: (error, stack) {},
    debugUi: false,
  );
}

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('${AppTheme.currentTheme.size.width}'),
        actions: [
          ThemeBrightnessButton(),
          if (!context.width6)
            IconButton(
              onPressed: () {
                context.showFormDialog(
                  builder: (context) {
                    return ThemeSettings();
                  },
                );
              },
              icon: Icon(Icons.settings),
            ),
        ],
      ),

      // endDrawer: SizedBox(height: 520, child: NavigationDrawerSection()),
      body: ListView(
        children: [
          ExpansionTile(title: Text("Typography"), children: [TypographyScreen()]),
          ExpansionTile(title: Text("Button"), children: [ButtonView()]),
          ExpansionTile(title: Text("Dropdown"), children: [DropdownView()]),
          ExpansionTile(title: Text("Selector"), children: [SelectorView()]),
          ExpansionTile(title: Text("Input"), children: [InputView()]),
          ExpansionTile(title: Text("Bar"), children: [BarView()]),
          ExpansionTile(title: Text("Dialog"), children: [DiaglogView()]),
          ExpansionTile(title: Text("Nav"), children: [NavView()]),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint(">>> ${GoRouter.maybeOf(context)}");
          debugPrint(">>> ${GoRouter.maybeOf(Electric.navigatorContext)}");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                context.push("/travel");
              },
              title: Text("Travel"),
            ),
          ],
        ),
      ),
    );
  }
}
