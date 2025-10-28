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
import 'package:example/widgetbook.dart';
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
      return DebugWrapper(
        paths: [
          DrawerLink(label: "Compass", path: '/compass'),
          DrawerLink(label: "Quiz", path: '/quiz'),
          DrawerLink(label: "Manager", path: '/manager'),
          DrawerLink(label: "Recipe", path: '/recipe'),
          DrawerLink(label: "Music", path: '/music'),
          DrawerLink(label: "ColorScheme", child: ColorSchemeExample()),
          DrawerLink(label: "Carousel", child: Carouselmain()),
          DrawerLink(
            label: "First",
            child: Scaffold(body: ListView(children: first(context))),
          ),
          DrawerLink(
            label: "Second",
            child: Scaffold(body: ListView(children: second(context))),
          ),
          DrawerLink(
            label: "Third",
            child: Scaffold(body: ListView(children: third(context))),
          ),
        ],
        child: child ?? Text("Error"),
      );
    },
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    themes: [
      AppTheme(
        name: "quiz",
        icon: CupertinoIcons.sun_min,

        dark: true,

        size: const Size(360, 780),
        maxSize: const Size(1366, 1024),
        designSize: const Size(360, 780),

        borderRadius: (24, 30),
        padding: (16, 18),

        primary: const Color(0xff717171),
        secondary: Color(0xFF787bce),
        tertiary: Color(0xFFEFD24F),

        bodyTextStyle: (s) => GoogleFonts.robotoMono(textStyle: s),
        headlineTextStyle: (s) => GoogleFonts.outfit(textStyle: s),

        baseunit: 1.0,
      ),
      AppTheme(
        name: "manager",
        icon: CupertinoIcons.sun_min,

        dark: false,

        size: const Size(360, 780),
        maxSize: const Size(1366, 1024),
        designSize: const Size(360, 780),

        borderRadius: (0, 0),
        padding: (16, 18),

        primary: const Color.fromARGB(255, 39, 39, 39),
        secondary: Color(0xFF787bce),
        tertiary: Color.fromARGB(255, 90, 239, 79),

        baseunit: 1.0,
      ),
      AppTheme(
        name: "Monochrome",
        icon: Icons.icecream_outlined,

        dark: false,

        size: const Size(360, 780),
        maxSize: const Size(1366, 1024),
        designSize: const Size(360, 780),

        borderRadius: (8, 10),
        padding: (14, 16),

        primary: const Color.fromARGB(255, 105, 187, 255),
        secondary: const Color.fromARGB(255, 255, 109, 157),
        tertiary: Colors.yellow,

        themedata: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
          dynamicSchemeVariant: DynamicSchemeVariant.monochrome,
        ),

        baseunit: 1.0,
      ),
      AppTheme(
        name: "TonalSpot",
        icon: Icons.icecream_outlined,

        dark: false,

        size: const Size(360, 780),
        maxSize: const Size(1366, 1024),
        designSize: const Size(360, 780),

        borderRadius: (8, 10),
        padding: (14, 16),

        primary: const Color.fromARGB(255, 105, 187, 255),
        secondary: const Color.fromARGB(255, 255, 109, 157),
        tertiary: Colors.yellow,

        themedata: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
          dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
        ),

        baseunit: 1.0,
      ),
      AppTheme(
        name: "MonochromeNight",
        icon: Icons.icecream_outlined,

        dark: true,

        size: const Size(360, 780),
        maxSize: const Size(1366, 1024),
        designSize: const Size(360, 780),

        borderRadius: (8, 10),
        padding: (14, 16),

        primary: const Color.fromARGB(255, 105, 187, 255),
        secondary: const Color.fromARGB(255, 255, 109, 157),
        tertiary: Colors.yellow,

        themedata: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
          dynamicSchemeVariant: DynamicSchemeVariant.monochrome,
        ),

        baseunit: 1.0,
      ),
    ],
    router: (navigatorKey) => GoRouter(
      navigatorKey: navigatorKey,
      debugLogDiagnostics: true,
      initialLocation: initialLocation,
      errorPageBuilder: (context, state) {
        return MaterialPage(
          child: Scaffold(body: Text(state.error.toString())),
        );
      },
      routes: [
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
        GoRoute(
          path: "/widget_book",
          builder: (context, state) {
            return MyWidgetbook();
          },
        ),
      ],
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

      endDrawer: IntrinsicWidth(
        child: SizedBox(height: 420, child: NavigationRailSection()),
      ),

      // endDrawer: SizedBox(height: 520, child: NavigationDrawerSection()),
      body: context.width6
          ? Row(
              children: [
                ThemeSettings(),
                Expanded(child: ListView(children: first(context))),
                Expanded(child: ListView(children: second(context))),
                Expanded(child: ListView(children: third(context))),
              ],
            )
          : ListView(
              children: [
                ...first(context),
                ...second(context),
                ...third(context),
              ],
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(">>> ${GoRouter.maybeOf(context)}");
          print(">>> ${GoRouter.maybeOf(Electric.navigatorContext)}");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

List<Widget> first(BuildContext context) => [
  Wrap(
    children: <Widget>[
      Buttons(isDisabled: false, hasIcon: false),
      Buttons(isDisabled: false, hasIcon: true),
      Buttons(isDisabled: true, hasIcon: false),
    ],
  ),
  Wrap(
    children: [
      IconButton.filled(
        icon: const Icon(Icons.settings_outlined),
        selectedIcon: const Icon(Icons.settings),
        onPressed: () {},
      ),
      IconButton.filledTonal(
        icon: const Icon(Icons.settings_outlined),
        selectedIcon: const Icon(Icons.settings),
        onPressed: () {},
      ),
      IconButton.outlined(
        icon: const Icon(Icons.settings_outlined),
        selectedIcon: const Icon(Icons.settings),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.settings_outlined),
        selectedIcon: const Icon(Icons.settings),
        onPressed: () {},
      ),
      IconButton.filled(
        isSelected: true,
        icon: const Icon(Icons.settings_outlined),
        selectedIcon: const Icon(Icons.settings),
        onPressed: () {},
      ),
      IconButton.filledTonal(
        isSelected: true,
        icon: const Icon(Icons.settings_outlined),
        selectedIcon: const Icon(Icons.settings),
        onPressed: () {},
      ),
      IconButton.outlined(
        isSelected: true,
        icon: const Icon(Icons.settings_outlined),
        selectedIcon: const Icon(Icons.settings),
        onPressed: () {},
      ),
      IconButton(
        isSelected: true,
        icon: const Icon(Icons.settings_outlined),
        selectedIcon: const Icon(Icons.settings),
        onPressed: () {},
      ),
    ],
  ),
  Wrap(
    children: [
      ActionChip(
        label: const Text('Assist'),
        avatar: const Icon(Icons.event),
        onPressed: () {},
      ),
      FilterChip(
        label: const Text('Filter'),
        selected: true,
        onSelected: (selected) {},
      ),
      InputChip(label: const Text('Input'), onPressed: () {}, onDeleted: () {}),
    ],
  ),
  Dropdown(),

  SegmentedButton<String>(
    segments: const <ButtonSegment<String>>[
      ButtonSegment(value: "Sizes.extraSmall", label: Text('XS')),
      ButtonSegment(value: "Sizes.small", label: Text('S')),
      ButtonSegment(value: "Sizes.medium", label: Text('M')),
      ButtonSegment(value: "Sizes.large", label: Text('L')),
      ButtonSegment(value: "Sizes.extraLarge", label: Text('XL')),
    ],
    selected: {"Sizes.small"},
    onSelectionChanged: (newSelection) {},
    multiSelectionEnabled: true,
  ),

  Row(
    children: [
      Flexible(
        child: OptionBox(
          options: [
            Option(value: "Witch", subtitle: Text("witch"), selected: true),
            Option(value: "Wizard"),
            Option(value: "Sorceror"),
          ],
        ),
      ),
      Flexible(
        child: OptionBox(
          options: [
            Option(value: "Witch", selected: true),
            Option(value: "Wizard"),
            Option(value: "Sorceror"),
          ],
          multi: true,
        ),
      ),
    ],
  ),

  Row(
    children: [
      Flexible(
        child: OptionBox(
          options: [
            Option(value: "Witch", selected: true),
            Option(value: "Wizard"),
            Option(value: "Sorceror"),
          ],
          multi: false,
          display: OptionDisplay.switchTile,
        ),
      ),

      Flexible(
        child: OptionBox(
          options: [
            Option(value: "Witch", selected: true),
            Option(value: "Wizard"),
            Option(value: "Sorceror"),
          ],
          display: OptionDisplay.chip,
        ),
      ),
    ],
  ),
];

List<Widget> second(BuildContext context) => [
  Slider(max: 100, divisions: 5, value: 30, label: "30", onChanged: (value) {}),
  SizedBox(height: 8),
  LinearProgressIndicator(
    value: .5,
    minHeight: 10,
    // color: purple,
    borderRadius: BorderRadius.circular(8),
  ),

  NavigationBar(
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    selectedIndex: 1,
    onDestinationSelected: (int index) {},
    destinations: const <Widget>[
      NavigationDestination(icon: Icon(Icons.explore), label: 'Explore'),
      NavigationDestination(icon: Icon(Icons.commute), label: 'Commute'),
      NavigationDestination(
        selectedIcon: Icon(Icons.bookmark),
        icon: Icon(Icons.bookmark_border),
        label: 'Saved',
      ),
    ],
  ),

  BottomAppBar(
    child: Row(
      children: <Widget>[
        const IconButtonAnchorExample(),
        IconButton(
          tooltip: 'Search',
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          tooltip: 'Favorite',
          icon: const Icon(Icons.favorite),
          onPressed: () {},
        ),
      ],
    ),
  ),

  BottomNavigationBar(
    showUnselectedLabels: true,
    onTap: (value) {},
    items: const [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart), label: 'Cart'),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border_outlined),
        label: 'Review',
      ),
    ],
  ),

  DefaultTabController(
    length: 3,
    child: TabBar(
      tabs: const <Widget>[
        Tab(
          icon: Icon(Icons.videocam_outlined),
          text: 'Video',
          iconMargin: EdgeInsets.only(bottom: 0.0),
        ),
        Tab(
          icon: Icon(Icons.photo_outlined),
          text: 'Photos',
          iconMargin: EdgeInsets.only(bottom: 0.0),
        ),
        Tab(
          icon: Icon(Icons.audiotrack_sharp),
          text: 'Audio',
          iconMargin: EdgeInsets.only(bottom: 0.0),
        ),
      ],
    ),
  ),

  AlertDialog(
    title: const Text('What is a dialog?'),
    content: const Text(
      'A dialog is a type of modal window that appears in front of app content to provide critical information, or prompt for a decision to be made.',
    ),
    actions: <Widget>[
      OutlinedButton(
        child: const Text('Dismiss'),
        onPressed: () => Navigator.of(context).pop(),
      ),
      FilledButton(
        child: const Text('Okay'),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  ),

  MaterialBanner(
    content: const Text(
      'A dialog is a type of modal window that appears in front of app content to provide critical information, or prompt for a decision to be made.',
    ),
    actions: <Widget>[
      OutlinedButton(
        child: const Text('Dismiss'),
        onPressed: () => Navigator.of(context).pop(),
      ),
      FilledButton(
        child: const Text('Okay'),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  ),
];

List<Widget> third(BuildContext context) => [
  Wrap(
    children: [
      SizedBox(height: 360, child: NavigationDrawerSection()),

      SizedBox(
        height: 320,
        child: IntrinsicWidth(child: NavigationRailSection()),
      ),
    ],
  ),

  ExpansionPanelList(
    materialGapSize: 0,
    children: [
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: true,
        headerBuilder: (context, isExpanded) => Text("Header"),
        body: Text("Body"),
      ),
      ExpansionPanel(
        canTapOnHeader: true,
        headerBuilder: (context, isExpanded) => Text("Header"),
        body: Text("Body"),
      ),
    ],
  ),

  // SizedBox(width: 40, height: 40, child: GradientLoader()),

  // CircularProgress(
  //   size: 50,
  //   secondaryColor: Colors.red,
  //   primaryColor: Colors.yellow,
  // ),
  NeonButton(
    color: context.cs.tertiary,
    builder: (completed) => Text(
      "Hello",
      style: GoogleFonts.agbalumo(
        textStyle: context.h6.c(
          completed ? context.cs.onTertiary : context.cs.tertiary,
        ),
      ),
    ),
  ),

  DataTable(
    columns: const <DataColumn>[
      DataColumn(
        label: Expanded(
          child: Text('Name', style: TextStyle(fontStyle: FontStyle.italic)),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text('Age', style: TextStyle(fontStyle: FontStyle.italic)),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text('Role', style: TextStyle(fontStyle: FontStyle.italic)),
        ),
      ),
    ],
    rows: const <DataRow>[
      DataRow(
        cells: <DataCell>[
          DataCell(Text('Sarah')),
          DataCell(Text('19')),
          DataCell(Text('Student')),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(Text('Janine')),
          DataCell(Text('43')),
          DataCell(Text('Professor')),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(Text('William')),
          DataCell(Text('27')),
          DataCell(Text('Associate Professor')),
        ],
      ),
    ],
  ),

  Wrap(
    alignment: WrapAlignment.spaceEvenly,
    children: [
      TextButton(
        child: const Text('Show modal navigation drawer'),
        onPressed: () {},
      ),
      TextButton(
        child: const Text('Show modal bottom sheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            showDragHandle: true,
            context: context,
            constraints: const BoxConstraints(maxWidth: 640),
            builder: (context) {
              return SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [Text("Hello")],
                  ),
                ),
              );
            },
          );
        },
      ),
      TextButton(
        child: Text('Show bottom sheet'),
        onPressed: () {
          showBottomSheet(
            elevation: 8.0,
            context: context,
            constraints: const BoxConstraints(maxWidth: 640),
            builder: (context) {
              return SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [Text("Hello")],
                  ),
                ),
              );
            },
          );
        },
      ),
    ],
  ),
];

//------------

class TypographyScreen extends StatelessWidget {
  const TypographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: Row(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 8),
                Text('Display Large', style: context.dl),
                Text('Display Medium', style: context.dm),
                Text('Display Small', style: context.ds),
                Text('Headline Large', style: context.hl),
                Text('Headline Medium', style: context.hm),
                Text('Headline Small', style: context.hs),
                Text('Title Large', style: context.tl),
                Text('Title Medium', style: context.tm),
                Text('Title Small', style: context.ts),
                Text('Body Large', style: context.bl),
                Text('Body Medium', style: context.bm),
                Text('Body Small', style: context.bs),
                Text('Label Large', style: context.ll),
                Text('Label Medium', style: context.lm),
                Text('Label Small', style: context.ls),
              ],
            ),
          ),
          Expanded(
            child: Theme(
              data: ThemeData(brightness: context.brightness),
              child: Builder(
                builder: (context) {
                  return ListView(
                    children: <Widget>[
                      const SizedBox(height: 8),
                      Text('Display Large', style: context.dl),
                      Text('Display Medium', style: context.dm),
                      Text('Display Small', style: context.ds),
                      Text('Headline Large', style: context.hl),
                      Text('Headline Medium', style: context.hm),
                      Text('Headline Small', style: context.hs),
                      Text('Title Large', style: context.tl),
                      Text('Title Medium', style: context.tm),
                      Text('Title Small', style: context.ts),
                      Text('Body Large', style: context.bl),
                      Text('Body Medium', style: context.bm),
                      Text('Body Small', style: context.bs),
                      Text('Label Large', style: context.ll),
                      Text('Label Medium', style: context.lm),
                      Text('Label Small', style: context.ls),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//------------

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ThemeSelector(),
            ListTile(
              onTap: () {
                context.push("/carousel");
              },
              title: Text("Carousel"),
            ),
            ListTile(
              onTap: () {
                context.push("/quiz");
              },
              title: Text("Quiz"),
            ),
            ListTile(
              onTap: () {
                context.push("/manager");
              },
              title: Text("Manager"),
            ),
            ListTile(
              onTap: () {
                context.push("/compass");
              },
              title: Text("Compass"),
            ),
            ListTile(
              onTap: () {
                context.push("/recipe");
              },
              title: Text("Recipe"),
            ),
            ListTile(
              onTap: () {
                context.push("/music");
              },
              title: Text("Music"),
            ),
            ListTile(
              onTap: () {
                context.push("/games");
              },
              title: Text("Games"),
            ),
            ListTile(
              onTap: () {
                context.push("/funko");
              },
              title: Text("Funko"),
            ),
            ListTile(
              onTap: () {
                context.push("/travel");
              },
              title: Text("Travel"),
            ),
            ListTile(
              onTap: () {
                context.push("/node_editor");
              },
              title: Text("Node Editor"),
            ),
            ListTile(
              onTap: () {
                context.push("/widget_book");
              },
              title: Text("Widget Book"),
            ),
          ],
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  final bool isDisabled;
  final bool hasIcon;

  const Buttons({super.key, required this.isDisabled, required this.hasIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            hasIcon
                ? ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Icon'),
                  )
                : ElevatedButton(
                    onPressed: isDisabled ? null : () {},
                    child: const Text('Elevated'),
                  ),
            hasIcon
                ? FilledButton.icon(
                    onPressed: () {},
                    label: const Text('Icon'),
                    icon: const Icon(Icons.add),
                  )
                : FilledButton(
                    onPressed: isDisabled ? null : () {},
                    child: const Text('Filled'),
                  ),
            hasIcon
                ? FilledButton.tonalIcon(
                    onPressed: () {},
                    label: const Text('Icon'),
                    icon: const Icon(Icons.add),
                  )
                : FilledButton.tonal(
                    onPressed: isDisabled ? null : () {},
                    child: const Text('Filled tonal'),
                  ),
            hasIcon
                ? OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Icon'),
                  )
                : OutlinedButton(
                    onPressed: isDisabled ? null : () {},
                    child: const Text('Outlined'),
                  ),

            hasIcon
                ? TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Icon'),
                  )
                : TextButton(
                    onPressed: isDisabled ? null : () {},
                    child: const Text('Text'),
                  ),
          ],
        ),
      ),
    );
  }
}

class NavigationDrawerSection extends StatefulWidget {
  const NavigationDrawerSection({super.key});

  @override
  State<NavigationDrawerSection> createState() =>
      _NavigationDrawerSectionState();
}

class _NavigationDrawerSectionState extends State<NavigationDrawerSection> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      onDestinationSelected: (selectedIndex) {
        setState(() {
          navDrawerIndex = selectedIndex;
        });
      },
      selectedIndex: navDrawerIndex,
      children: <Widget>[
        DrawerHeader(child: Text("Header")),

        ExpansionPanelList(
          materialGapSize: 0,
          elevation: 0,
          expandedHeaderPadding: EdgeInsets.all(0),
          children: [
            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: true,
              headerBuilder: (context, isExpanded) =>
                  ListTile(title: Text('Home', style: context.h6.w5)),

              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ...destinations.asMap().entries.map((destination) {
                      return ListTile(
                        leading: destination.value.icon,
                        title: Text(destination.value.label),
                        selected: destination.key == navDrawerIndex,
                        style: ListTileStyle.drawer,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        shape: destination.key != navDrawerIndex
                            ? null
                            : RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.all(
                                  Radius.circular(32),
                                ),
                              ),
                        onTap: () {
                          setState(() {
                            navDrawerIndex = destination.key;
                          });
                        },
                      );
                    }),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: true,
              headerBuilder: (context, isExpanded) =>
                  ListTile(title: Text('Home', style: context.h6.w5)),
              body: Column(
                children: destinations.asMap().entries.map((destination) {
                  return ListTile(
                    leading: destination.value.icon,
                    title: Text(destination.value.label),
                    selected: destination.key == navDrawerIndex,
                    onTap: () {
                      setState(() {
                        navDrawerIndex = destination.key;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        ...destinations.map((destination) {
          return NavigationDrawerDestination(
            label: Text(destination.label),
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
          );
        }),
        const Divider(indent: 28, endIndent: 28),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text('Labels', style: Theme.of(context).textTheme.titleSmall),
        ),
        ...destinations.map((destination) {
          return NavigationDrawerDestination(
            label: Text(destination.label),
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
          );
        }),
      ],
    );
  }
}

class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<ExampleDestination> destinations = <ExampleDestination>[
  ExampleDestination(
    'Dashboard',
    Icon(Icons.inbox_outlined),
    Icon(Icons.inbox),
  ),
  ExampleDestination(
    'Report Overview',
    Icon(Icons.send_outlined),
    Icon(Icons.send),
  ),
  ExampleDestination(
    'Insights',
    Icon(Icons.favorite_outline),
    Icon(Icons.favorite),
  ),
  ExampleDestination(
    'Manage Task',
    Icon(Icons.legend_toggle_sharp),
    Icon(Icons.legend_toggle_sharp),
  ),
  ExampleDestination('Settings', Icon(Icons.settings), Icon(Icons.settings)),
];

class NavigationRailSection extends StatefulWidget {
  const NavigationRailSection({super.key});

  @override
  State<NavigationRailSection> createState() => _NavigationRailSectionState();
}

class _NavigationRailSectionState extends State<NavigationRailSection> {
  int navRailIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      onDestinationSelected: (selectedIndex) {
        setState(() {
          navRailIndex = selectedIndex;
        });
      },
      elevation: 4,
      leading: FloatingActionButton(
        heroTag: "railnav",
        child: const Icon(Icons.create),
        onPressed: () {},
      ),
      groupAlignment: 0.0,
      selectedIndex: navRailIndex,
      labelType: NavigationRailLabelType.selected,
      destinations: <NavigationRailDestination>[
        ...destinations.map((destination) {
          return NavigationRailDestination(
            label: Text(destination.label),
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
          );
        }),
      ],
    );
  }
}

//------------

class IconButtonAnchorExample extends StatelessWidget {
  const IconButtonAnchorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.more_vert),
        );
      },
      menuChildren: [
        MenuItemButton(child: const Text('Menu 1'), onPressed: () {}),
        MenuItemButton(child: const Text('Menu 2'), onPressed: () {}),
        SubmenuButton(
          menuChildren: <Widget>[
            MenuItemButton(onPressed: () {}, child: const Text('Menu 3.1')),
            MenuItemButton(onPressed: () {}, child: const Text('Menu 3.2')),
            MenuItemButton(onPressed: () {}, child: const Text('Menu 3.3')),
          ],
          child: const Text('Menu 3'),
        ),
      ],
    );
  }
}

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<String> entries = ["Smile", "Cloud", "Heart"];

    return Wrap(
      alignment: WrapAlignment.spaceAround,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      runSpacing: 4,
      children: [
        DropdownButton(
          hint: Text("Color"),
          // selectedItemBuilder: (context) {
          //   return [Text("Hello"), Text("Hi")];
          // },
          value: "Smile",
          items: entries
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (value) {},
        ),
        SizedBox(
          width: 150,
          child: DropdownButtonFormField(
            hint: Text("Color"),
            items: entries
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {},
          ),
        ),
        DropdownMenu(
          controller: colorController,
          label: const Text('Color'),
          enableFilter: true,
          dropdownMenuEntries: entries
              .map(
                (e) => DropdownMenuEntry<String>(
                  value: e,
                  label: e,
                  enabled: e != 'Grey',
                ),
              )
              .toList(),
          inputDecorationTheme: const InputDecorationTheme(filled: true),
          onSelected: (color) {},
        ),
        DropdownMenu(
          initialSelection: "Smile",
          controller: iconController,
          leadingIcon: const Icon(Icons.search),
          label: const Text('Icon'),
          dropdownMenuEntries: entries
              .map(
                (e) => DropdownMenuEntry<String>(
                  value: e,
                  label: e,
                  enabled: e != 'Grey',
                ),
              )
              .toList(),
          onSelected: (icon) {},
        ),
      ],
    );
  }
}

//------------

const Widget divider = SizedBox(height: 10);

class ColorSchemeExample extends StatefulWidget {
  const ColorSchemeExample({super.key});

  @override
  State<ColorSchemeExample> createState() => _ColorSchemeExampleState();
}

class _ColorSchemeExampleState extends State<ColorSchemeExample> {
  Color selectedColor = ColorSeed.baseColor.color;
  Brightness selectedBrightness = Brightness.light;
  double selectedContrast = 0.0;
  static const List<DynamicSchemeVariant> schemeVariants =
      DynamicSchemeVariant.values;

  void updateTheme(Brightness brightness, Color color, double contrastLevel) {
    setState(() {
      selectedBrightness = brightness;
      selectedColor = color;
      selectedContrast = contrastLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: selectedColor,
          brightness: selectedBrightness,
          contrastLevel: selectedContrast,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: const Text('ColorScheme'),
          actions: <Widget>[
            SettingsButton(
              selectedColor: selectedColor,
              selectedBrightness: selectedBrightness,
              selectedContrast: selectedContrast,
              updateTheme: updateTheme,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ColorSchemeVariantColumn(
                        colorScheme: context.cs,
                        selectedColor: selectedColor,
                        brightness: selectedBrightness,
                        schemeVariant: schemeVariants[0],
                        contrastLevel: selectedContrast,
                      ),
                      ...List<Widget>.generate(schemeVariants.length, (
                        int index,
                      ) {
                        return ColorSchemeVariantColumn(
                          selectedColor: selectedColor,
                          brightness: selectedBrightness,
                          schemeVariant: schemeVariants[index],
                          contrastLevel: selectedContrast,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({
    super.key,
    required this.updateTheme,
    required this.selectedBrightness,
    required this.selectedContrast,
    required this.selectedColor,
  });

  final Brightness selectedBrightness;
  final double selectedContrast;
  final Color selectedColor;

  final void Function(Brightness, Color, double) updateTheme;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late Brightness selectedBrightness = widget.selectedBrightness;
  late Color selectedColor = widget.selectedColor;
  late double selectedContrast = widget.selectedContrast;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: selectedColor,
          contrastLevel: selectedContrast,
          brightness: selectedBrightness,
        ),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              Center(
                child: Text(
                  'Settings',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Row(
                children: <Widget>[
                  const Text('Brightness: '),
                  Switch(
                    value: selectedBrightness == Brightness.light,
                    onChanged: (bool value) {
                      setState(() {
                        selectedBrightness = value
                            ? Brightness.light
                            : Brightness.dark;
                      });
                      widget.updateTheme(
                        selectedBrightness,
                        selectedColor,
                        selectedContrast,
                      );
                    },
                  ),
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  const Text('Seed color: '),
                  ...List<Widget>.generate(ColorSeed.values.length, (
                    int index,
                  ) {
                    final Color itemColor = ColorSeed.values[index].color;
                    return IconButton(
                      icon: selectedColor == ColorSeed.values[index].color
                          ? Icon(Icons.circle, color: itemColor)
                          : Icon(Icons.circle_outlined, color: itemColor),
                      onPressed: () {
                        setState(() {
                          selectedColor = itemColor;
                        });
                        widget.updateTheme(
                          selectedBrightness,
                          selectedColor,
                          selectedContrast,
                        );
                      },
                    );
                  }),
                ],
              ),
              Row(
                children: <Widget>[
                  const Text('Contrast level: '),
                  Expanded(
                    child: Slider(
                      divisions: 4,
                      label: selectedContrast.toString(),
                      min: -1,
                      value: selectedContrast,
                      onChanged: (double value) {
                        setState(() {
                          selectedContrast = value;
                        });
                        widget.updateTheme(
                          selectedBrightness,
                          selectedColor,
                          selectedContrast,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorSchemeVariantColumn extends StatelessWidget {
  const ColorSchemeVariantColumn({
    super.key,
    this.schemeVariant = DynamicSchemeVariant.tonalSpot,
    this.brightness = Brightness.light,
    this.contrastLevel = 0.0,
    required this.selectedColor,
    this.colorScheme,
  });

  final DynamicSchemeVariant schemeVariant;
  final Brightness brightness;
  final double contrastLevel;
  final Color selectedColor;

  final ColorScheme? colorScheme;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 250),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              schemeVariant.name == 'tonalSpot'
                  ? '${schemeVariant.name} (Default)'
                  : schemeVariant.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ColorSchemeView(
              colorScheme:
                  colorScheme ??
                  ColorScheme.fromSeed(
                    seedColor: selectedColor,
                    brightness: brightness,
                    contrastLevel: contrastLevel,
                    dynamicSchemeVariant: schemeVariant,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorSchemeView extends StatelessWidget {
  const ColorSchemeView({super.key, required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ColorGroup(
          children: <ColorChip>[
            ColorChip('primary', colorScheme.primary, colorScheme.onPrimary),
            ColorChip('onPrimary', colorScheme.onPrimary, colorScheme.primary),
            ColorChip(
              'primaryContainer',
              colorScheme.primaryContainer,
              colorScheme.onPrimaryContainer,
            ),
            ColorChip(
              'onPrimaryContainer',
              colorScheme.onPrimaryContainer,
              colorScheme.primaryContainer,
            ),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip(
              'primaryFixed',
              colorScheme.primaryFixed,
              colorScheme.onPrimaryFixed,
            ),
            ColorChip(
              'onPrimaryFixed',
              colorScheme.onPrimaryFixed,
              colorScheme.primaryFixed,
            ),
            ColorChip(
              'primaryFixedDim',
              colorScheme.primaryFixedDim,
              colorScheme.onPrimaryFixedVariant,
            ),
            ColorChip(
              'onPrimaryFixedVariant',
              colorScheme.onPrimaryFixedVariant,
              colorScheme.primaryFixedDim,
            ),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip(
              'secondary',
              colorScheme.secondary,
              colorScheme.onSecondary,
            ),
            ColorChip(
              'onSecondary',
              colorScheme.onSecondary,
              colorScheme.secondary,
            ),
            ColorChip(
              'secondaryContainer',
              colorScheme.secondaryContainer,
              colorScheme.onSecondaryContainer,
            ),
            ColorChip(
              'onSecondaryContainer',
              colorScheme.onSecondaryContainer,
              colorScheme.secondaryContainer,
            ),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip(
              'secondaryFixed',
              colorScheme.secondaryFixed,
              colorScheme.onSecondaryFixed,
            ),
            ColorChip(
              'onSecondaryFixed',
              colorScheme.onSecondaryFixed,
              colorScheme.secondaryFixed,
            ),
            ColorChip(
              'secondaryFixedDim',
              colorScheme.secondaryFixedDim,
              colorScheme.onSecondaryFixedVariant,
            ),
            ColorChip(
              'onSecondaryFixedVariant',
              colorScheme.onSecondaryFixedVariant,
              colorScheme.secondaryFixedDim,
            ),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip('tertiary', colorScheme.tertiary, colorScheme.onTertiary),
            ColorChip(
              'onTertiary',
              colorScheme.onTertiary,
              colorScheme.tertiary,
            ),
            ColorChip(
              'tertiaryContainer',
              colorScheme.tertiaryContainer,
              colorScheme.onTertiaryContainer,
            ),
            ColorChip(
              'onTertiaryContainer',
              colorScheme.onTertiaryContainer,
              colorScheme.tertiaryContainer,
            ),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip(
              'tertiaryFixed',
              colorScheme.tertiaryFixed,
              colorScheme.onTertiaryFixed,
            ),
            ColorChip(
              'onTertiaryFixed',
              colorScheme.onTertiaryFixed,
              colorScheme.tertiaryFixed,
            ),
            ColorChip(
              'tertiaryFixedDim',
              colorScheme.tertiaryFixedDim,
              colorScheme.onTertiaryFixedVariant,
            ),
            ColorChip(
              'onTertiaryFixedVariant',
              colorScheme.onTertiaryFixedVariant,
              colorScheme.tertiaryFixedDim,
            ),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip('error', colorScheme.error, colorScheme.onError),
            ColorChip('onError', colorScheme.onError, colorScheme.error),
            ColorChip(
              'errorContainer',
              colorScheme.errorContainer,
              colorScheme.onErrorContainer,
            ),
            ColorChip(
              'onErrorContainer',
              colorScheme.onErrorContainer,
              colorScheme.errorContainer,
            ),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip('surface', colorScheme.surface, colorScheme.onSurface),
            ColorChip(
              'surfaceBright',
              colorScheme.surfaceBright,
              colorScheme.onSurface,
            ),
            ColorChip(
              'surfaceContainerLowest',
              colorScheme.surfaceContainerLowest,
              colorScheme.onSurface,
            ),
            ColorChip(
              'surfaceContainerLow',
              colorScheme.surfaceContainerLow,
              colorScheme.onSurface,
            ),
            ColorChip(
              'surfaceContainer',
              colorScheme.surfaceContainer,
              colorScheme.onSurface,
            ),
            ColorChip(
              'surfaceContainerHigh',
              colorScheme.surfaceContainerHigh,
              colorScheme.onSurface,
            ),
            ColorChip(
              'surfaceContainerHighest',
              colorScheme.surfaceContainerHighest,
              colorScheme.onSurface,
            ),
            ColorChip(
              'surfaceDim',
              colorScheme.surfaceDim,
              colorScheme.onSurface,
            ),

            ColorChip('onSurface', colorScheme.onSurface, colorScheme.surface),
            ColorChip(
              'onSurfaceVariant',
              colorScheme.onSurfaceVariant,
              colorScheme.surfaceContainerHighest,
            ),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip('outline', colorScheme.outline, null),
            ColorChip('shadow', colorScheme.shadow, null),
            ColorChip(
              'inverseSurface',
              colorScheme.inverseSurface,
              colorScheme.onInverseSurface,
            ),
            ColorChip(
              'onInverseSurface',
              colorScheme.onInverseSurface,
              colorScheme.inverseSurface,
            ),
            ColorChip(
              'inversePrimary',
              colorScheme.inversePrimary,
              colorScheme.primary,
            ),
          ],
        ),
      ],
    );
  }
}

class ColorGroup extends StatelessWidget {
  const ColorGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(children: children),
      ),
    );
  }
}

class ColorChip extends StatelessWidget {
  const ColorChip(this.label, this.color, this.onColor, {super.key});

  final Color color;
  final Color? onColor;
  final String label;

  static Color contrastColor(Color color) {
    final Brightness brightness = ThemeData.estimateBrightnessForColor(color);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final Color labelColor = onColor ?? contrastColor(color);
    return ColoredBox(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Expanded>[
            Expanded(
              child: Text(label, style: TextStyle(color: labelColor)),
            ),
          ],
        ),
      ),
    );
  }
}

enum ColorSeed {
  baseColor('M3 Baseline', Color(0xff6750a4)),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink),
  brightBlue('Bright Blue', Color(0xFF0000FF)),
  brightGreen('Bright Green', Color(0xFF00FF00)),
  brightRed('Bright Red', Color(0xFFFF0000));

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
    required this.updateTheme,
    required this.selectedBrightness,
    required this.selectedContrast,
    required this.selectedColor,
  });

  final Brightness selectedBrightness;
  final double selectedContrast;
  final Color selectedColor;

  final void Function(Brightness, Color, double) updateTheme;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        showModalBottomSheet<void>(
          barrierColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return Settings(
              selectedColor: selectedColor,
              selectedBrightness: selectedBrightness,
              selectedContrast: selectedContrast,
              updateTheme: updateTheme,
            );
          },
        );
      },
    );
  }
}
