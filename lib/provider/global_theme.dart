import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonspace/form/color.dart';
import 'package:moonspace/helper/extensions/color.dart';
import 'package:moonspace/theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:moonspace/provider/pref.dart';

part 'global_theme.g.dart';

enum ThemeType {
  system(Icon(CupertinoIcons.cloud_sun_rain)),
  night(Icon(CupertinoIcons.moon_stars)),
  light(Icon(CupertinoIcons.sun_min)),
  clight(Icon(CupertinoIcons.sun_dust)),
  cnight(Icon(CupertinoIcons.cloud_moon));

  final Icon icon;

  const ThemeType(this.icon);

  static ThemeType from(String? v) {
    v = v ?? ThemeType.system.toString();

    return ThemeType.values.where((e) => e.toString() == v).first;
  }

  Brightness get brightness {
    if (this == ThemeType.night) {
      return Brightness.dark;
    }
    if (this == ThemeType.light) {
      return Brightness.light;
    }
    return SchedulerBinding.instance.platformDispatcher.platformBrightness;
  }
}

class GlobalAppTheme {
  final ThemeType type;

  final int themeIndex;

  final Color primary;
  final Color secondary;
  final Color tertiary;

  final double baseunit;

  GlobalAppTheme({
    required this.type,
    required this.themeIndex,
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.baseunit,
  });
}

const String _themetype = 'themetype';
const String _themeindex = 'themeindex';
const String _primary = 'primary';
const String _secondary = 'secondary';
const String _tertiary = 'tertiary';
const String _baseunit = 'baseunit';

@Riverpod(keepAlive: true)
class GlobalTheme extends _$GlobalTheme {
  @override
  GlobalAppTheme build() {
    ref.watch(prefProvider);

    ThemeType theme = ThemeType.from(
      ref.read(prefProvider.notifier).getString(_themetype),
    );
    int appthemeIndex =
        ref.read(prefProvider.notifier).getInt(_themeindex) ?? 0;
    Color? primary = ref
        .read(prefProvider.notifier)
        .getString(_primary)
        ?.tryToColor();
    Color? secondary = ref
        .read(prefProvider.notifier)
        .getString(_secondary)
        ?.tryToColor();
    Color? tertiary = ref
        .read(prefProvider.notifier)
        .getString(_tertiary)
        ?.tryToColor();
    double? baseunit = ref.read(prefProvider.notifier).getDouble(_baseunit);

    changeTheme(theme, primary, secondary, tertiary, appthemeIndex, baseunit);

    return GlobalAppTheme(
      type: theme,
      themeIndex: appthemeIndex,
      primary: primary ?? const Color.fromARGB(255, 255, 0, 0),
      secondary: secondary ?? const Color.fromARGB(255, 255, 0, 0),
      tertiary: tertiary ?? const Color.fromARGB(255, 255, 59, 59),
      baseunit: baseunit ?? 1.0,
    );
  }

  void setTheme({
    ThemeType? type,
    String? name,
    Color? primary,
    Color? secondary,
    Color? tertiary,
    double? baseunit,
  }) {
    int? themeIndex = -1;
    if (name != null) {
      themeIndex = AppTheme.themes.indexWhere((t) => name == t.name);
    }
    if (type != null) {
      themeIndex = AppTheme.themes.indexWhere((apptheme) {
        if ((type.brightness == Brightness.dark) == apptheme.dark) {
          return true;
        }
        return false;
      });
    }

    final ctype =
        type ??
        (AppTheme.themes[themeIndex].dark
            ? ThemeType.night
            : ThemeType.light); //state.type;
    final cthemeIndex = themeIndex >= 0 ? themeIndex : state.themeIndex;
    final cPrimary = primary ?? state.primary;
    final cSecondary = secondary ?? state.secondary;
    final cTertiary = tertiary ?? state.tertiary;
    final cBaseunit = baseunit ?? state.baseunit;

    changeTheme(ctype, cPrimary, cSecondary, cTertiary, cthemeIndex, cBaseunit);

    state = GlobalAppTheme(
      type: ctype,
      themeIndex: cthemeIndex,
      primary: cPrimary,
      secondary: cSecondary,
      tertiary: cTertiary,
      baseunit: cBaseunit,
    );

    ref
        .read(prefProvider.notifier)
        .saveString(_themetype, state.type.toString());
    ref.read(prefProvider.notifier).saveInt(_themeindex, cthemeIndex);
    ref.read(prefProvider.notifier).saveString(_primary, cPrimary.hexCode);
    ref.read(prefProvider.notifier).saveString(_secondary, cSecondary.hexCode);
    ref.read(prefProvider.notifier).saveString(_tertiary, cTertiary.hexCode);
  }

  void changeTheme(
    ThemeType theme,
    Color? primary,
    Color? secondary,
    Color? tertiary,
    int appthemeIndex,
    double? baseunit,
  ) {
    if (theme == ThemeType.clight || theme == ThemeType.cnight) {
      AppTheme.currentTheme = AppTheme(
        name: "custom",
        icon: CupertinoIcons.cloud_sun_bolt,

        dark: theme == ThemeType.cnight,
        size: const Size(100, 100),
        maxSize: const Size(1366, 1024),
        designSize: const Size(430, 932),

        primary: primary ?? Colors.red,
        secondary: secondary ?? Colors.red,
        tertiary: tertiary ?? Colors.red,

        borderRadius: (8, 10),
        padding: (14, 16),
        baseunit: baseunit ?? 1.0,
      );
    } else {
      AppTheme.currentThemeIndex = appthemeIndex;
      AppTheme.currentTheme = AppTheme.themes[appthemeIndex];
    }
  }
}

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalAppTheme globalAppTheme = ref.watch(globalThemeProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ThemeTypePopupButton(),

          if (globalAppTheme.type != ThemeType.clight &&
              globalAppTheme.type != ThemeType.cnight)
            ThemePopupButton(),

          if (globalAppTheme.type == ThemeType.clight ||
              globalAppTheme.type == ThemeType.cnight)
            ColorPicker(
              title: Text("Primary"),
              showHexCode: true,
              initialColor: globalAppTheme.primary,
              onChange: (color) {
                ref.read(globalThemeProvider.notifier).setTheme(primary: color);
              },
            ),

          if (globalAppTheme.type == ThemeType.clight ||
              globalAppTheme.type == ThemeType.cnight)
            ColorPicker(
              title: Text("Secondary"),
              showHexCode: true,
              initialColor: globalAppTheme.secondary,
              onChange: (color) {
                ref
                    .read(globalThemeProvider.notifier)
                    .setTheme(secondary: color);
              },
            ),

          if (globalAppTheme.type == ThemeType.clight ||
              globalAppTheme.type == ThemeType.cnight)
            ColorPicker(
              title: Text("Tertiary"),
              showHexCode: true,
              initialColor: globalAppTheme.tertiary,
              onChange: (color) {
                ref
                    .read(globalThemeProvider.notifier)
                    .setTheme(tertiary: color);
              },
            ),

          if (globalAppTheme.type == ThemeType.clight ||
              globalAppTheme.type == ThemeType.cnight)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Baseunit"),
                  Slider(
                    label: globalAppTheme.baseunit.toStringAsFixed(1),
                    value: globalAppTheme.baseunit,
                    divisions: 35,
                    max: 4.0,
                    min: 0.5,
                    padding: EdgeInsets.zero,
                    onChanged: (value) {
                      ref
                          .read(globalThemeProvider.notifier)
                          .setTheme(baseunit: value);
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class ThemePopupButton extends ConsumerWidget {
  const ThemePopupButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownMenu<int>(
      initialSelection: AppTheme.currentThemeIndex,
      dropdownMenuEntries: AppTheme.themes
          .asMap()
          .entries
          .map(
            (e) => DropdownMenuEntry<int>(
              value: e.key,
              label: e.value.name,
              labelWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    e.value.name.length > 8
                        ? e.value.name.substring(0, 8)
                        : e.value.name,
                  ),
                  Icon(e.value.icon),
                ],
              ),
            ),
          )
          .toList(),
      onSelected: (apptheme) {
        if (apptheme != null) {
          ref
              .read(globalThemeProvider.notifier)
              .setTheme(name: AppTheme.themes[apptheme].name);
        }
      },
    );
  }
}

class ThemeTypePopupButton extends ConsumerWidget {
  const ThemeTypePopupButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownMenu<ThemeType>(
      dropdownMenuEntries: ThemeType.values
          .map(
            (e) => DropdownMenuEntry<ThemeType>(
              value: e,
              label: e.name,
              labelWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(e.name.toUpperCase()), e.icon],
              ),
            ),
          )
          .toList(),
      onSelected: (type) {
        if (type != null) {
          ref.read(globalThemeProvider.notifier).setTheme(type: type);
        }
      },
    );
  }
}

class ThemeBrightnessButton extends ConsumerWidget {
  const ThemeBrightnessButton({super.key, this.showTooltipBelow = true});

  final bool showTooltipBelow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalAppTheme globalAppTheme = ref.watch(globalThemeProvider);

    return Tooltip(
      preferBelow: showTooltipBelow,
      message: 'Toggle brightness',
      child: IconButton(
        icon: globalAppTheme.type.icon,
        onPressed: () {
          final type = AppTheme.currentTheme.dark
              ? ThemeType.light
              : ThemeType.night;

          ref.read(globalThemeProvider.notifier).setTheme(type: type);
        },
      ),
    );
  }
}
