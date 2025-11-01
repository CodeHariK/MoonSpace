import 'package:example/app_routes.dart';
import 'package:example/app_themes.dart';
import 'package:example/basic/bar.dart';
import 'package:example/basic/button.dart';
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

import 'package:moon_debug/widgetbook.dart';

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
          MoonDrawerLink(label: "Compass", path: '/compass'),
          MoonDrawerLink(label: "Quiz", path: '/quiz'),
          MoonDrawerLink(label: "Manager", path: '/manager'),
          MoonDrawerLink(label: "Recipe", path: '/recipe'),
          MoonDrawerLink(label: "Music", path: '/music'),
          MoonDrawerLink(label: "ColorScheme", child: ColorSchemeExample()),
          MoonDrawerLink(label: "Carousel", child: Carouselmain()),
          MoonDrawerLink(
            label: "First",
            child: Scaffold(body: ListView(children: first(context))),
          ),
          MoonDrawerLink(
            label: "Third",
            child: Scaffold(body: ListView(children: third(context))),
          ),
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
      body: context.width6
          ? Row(
              children: [
                ThemeSettings(),
                Expanded(child: ListView(children: first(context))),
                Expanded(child: ListView(children: third(context))),
              ],
            )
          : ListView(children: [...first(context), ...third(context)]),

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

List<Widget> first(BuildContext context) => [
  ExpansionTile(title: Text("Typography"), children: [TypographyScreen()]),
  ExpansionTile(title: Text("Button"), children: [ButtonView()]),
  ExpansionTile(title: Text("Dropdown"), children: [DropdownView()]),
  ExpansionTile(title: Text("Selector"), children: [SelectorView()]),
  ExpansionTile(title: Text("Input"), children: [InputView()]),
  ExpansionTile(title: Text("Bar"), children: [BarView()]),
  ExpansionTile(title: Text("Dialog"), children: [DiaglogView()]),
  ExpansionTile(title: Text("Nav"), children: [NavView()]),
];

List<Widget> third(BuildContext context) => [
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
        textStyle: context.h6.c(completed ? context.cs.onTertiary : context.cs.tertiary),
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
        cells: <DataCell>[DataCell(Text('Sarah')), DataCell(Text('19')), DataCell(Text('Student'))],
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
      TextButton(child: const Text('Show modal navigation drawer'), onPressed: () {}),
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
  static const List<DynamicSchemeVariant> schemeVariants = DynamicSchemeVariant.values;

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
                      ...List<Widget>.generate(schemeVariants.length, (int index) {
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
              Center(child: Text('Settings', style: Theme.of(context).textTheme.titleLarge)),
              Row(
                children: <Widget>[
                  const Text('Brightness: '),
                  Switch(
                    value: selectedBrightness == Brightness.light,
                    onChanged: (bool value) {
                      setState(() {
                        selectedBrightness = value ? Brightness.light : Brightness.dark;
                      });
                      widget.updateTheme(selectedBrightness, selectedColor, selectedContrast);
                    },
                  ),
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  const Text('Seed color: '),
                  ...List<Widget>.generate(ColorSeed.values.length, (int index) {
                    final Color itemColor = ColorSeed.values[index].color;
                    return IconButton(
                      icon: selectedColor == ColorSeed.values[index].color
                          ? Icon(Icons.circle, color: itemColor)
                          : Icon(Icons.circle_outlined, color: itemColor),
                      onPressed: () {
                        setState(() {
                          selectedColor = itemColor;
                        });
                        widget.updateTheme(selectedBrightness, selectedColor, selectedContrast);
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
                        widget.updateTheme(selectedBrightness, selectedColor, selectedContrast);
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
            ColorChip('primaryFixed', colorScheme.primaryFixed, colorScheme.onPrimaryFixed),
            ColorChip('onPrimaryFixed', colorScheme.onPrimaryFixed, colorScheme.primaryFixed),
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
            ColorChip('secondary', colorScheme.secondary, colorScheme.onSecondary),
            ColorChip('onSecondary', colorScheme.onSecondary, colorScheme.secondary),
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
            ColorChip('secondaryFixed', colorScheme.secondaryFixed, colorScheme.onSecondaryFixed),
            ColorChip('onSecondaryFixed', colorScheme.onSecondaryFixed, colorScheme.secondaryFixed),
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
            ColorChip('onTertiary', colorScheme.onTertiary, colorScheme.tertiary),
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
            ColorChip('tertiaryFixed', colorScheme.tertiaryFixed, colorScheme.onTertiaryFixed),
            ColorChip('onTertiaryFixed', colorScheme.onTertiaryFixed, colorScheme.tertiaryFixed),
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
            ColorChip('errorContainer', colorScheme.errorContainer, colorScheme.onErrorContainer),
            ColorChip('onErrorContainer', colorScheme.onErrorContainer, colorScheme.errorContainer),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip('surface', colorScheme.surface, colorScheme.onSurface),
            ColorChip('surfaceBright', colorScheme.surfaceBright, colorScheme.onSurface),
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
            ColorChip('surfaceContainer', colorScheme.surfaceContainer, colorScheme.onSurface),
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
            ColorChip('surfaceDim', colorScheme.surfaceDim, colorScheme.onSurface),

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
            ColorChip('inverseSurface', colorScheme.inverseSurface, colorScheme.onInverseSurface),
            ColorChip('onInverseSurface', colorScheme.onInverseSurface, colorScheme.inverseSurface),
            ColorChip('inversePrimary', colorScheme.inversePrimary, colorScheme.primary),
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
