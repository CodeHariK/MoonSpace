import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moonspace/helper/extensions/color.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';

extension AppThemeNumber on num {
  double get a => (this * AppTheme.a).toDouble();
  double get s => (this * AppTheme.s).toDouble();
  double get m => (this * AppTheme.m).toDouble();
  double get c => (this * AppTheme.c).toDouble();
  double get mins => max(this, s).toDouble();
  double get maxs => min(this, s).toDouble();
  double get minc => max(this, c).toDouble();
  double get maxc => min(this, c).toDouble();
}

extension AppThemeRange on (num, num) {
  double get s => ($1 + ($2 - $1) * AppTheme.rs).toDouble();
  double get c =>
      AppTheme.currentTheme.baseunit *
      ($1 + ($2 - $1) * AppTheme.rc).toDouble();
}

TextStyle samestyle(TextStyle s) {
  return s;
}

class AppTheme {
  final String name;
  final IconData icon;

  final Size size;
  final Size maxSize;
  final Size designSize;

  final bool dark;
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final ColorScheme? themedata;

  final (int, int) borderRadius;
  final (int, int) padding;
  final bool inputfilled;
  final bool inputOutlined;

  final TextStyle Function(TextStyle style) bodyTextStyle;
  final TextStyle Function(TextStyle style) headlineTextStyle;

  final double baseunit;

  AppTheme copyWith({Size? size}) {
    return AppTheme(
      name: name,
      icon: icon,

      size: size ?? this.size,
      maxSize: maxSize,
      designSize: designSize,

      dark: dark,
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      themedata: themedata,

      borderRadius: borderRadius,
      padding: padding,

      bodyTextStyle: bodyTextStyle,
      headlineTextStyle: headlineTextStyle,

      baseunit: baseunit,
    );
  }

  AppTheme({
    required this.name,
    required this.icon,

    required this.size,
    required this.maxSize,
    required this.designSize,

    required this.dark,
    required this.primary,
    required this.secondary,
    required this.tertiary,
    this.themedata,

    required this.borderRadius,
    required this.padding,

    this.inputOutlined = false,
    this.inputfilled = false,

    this.bodyTextStyle = samestyle,
    this.headlineTextStyle = samestyle,

    required this.baseunit,
  });

  static List<AppTheme> themes = [
    // static List<AppTheme> get themes => [
    AppTheme(
      name: "Sun",
      icon: CupertinoIcons.sun_min,

      dark: false,

      size: const Size(360, 780),
      maxSize: const Size(1366, 1024),
      designSize: const Size(360, 780),

      borderRadius: (8, 10),
      padding: (14, 16),

      primary: const Color(0xff717171),
      secondary: const Color(0xff7e73c0),
      tertiary: const Color(0xff71c783),

      baseunit: 1.0,
    ),
    AppTheme(
      name: "Moon",
      icon: CupertinoIcons.moon,

      dark: true,

      size: const Size(360, 780),
      maxSize: const Size(1366, 1024),
      designSize: const Size(360, 780),

      borderRadius: (8, 10),
      padding: (14, 16),

      primary: const Color(0xff8a73cf),
      secondary: const Color(0xffb2d2a4),
      tertiary: const Color(0xffffffff),

      baseunit: 1.0,
    ),
  ];

  static int currentThemeIndex = 0;
  static AppTheme currentTheme = themes[currentThemeIndex];

  static bool get isDark => currentTheme.dark;

  static double get w => currentTheme.size.width;
  static double get dw => currentTheme.designSize.width;
  static double get mw => currentTheme.maxSize.width;
  static double get h => currentTheme.size.height;
  static double get dh => currentTheme.designSize.height;
  static double get mh => currentTheme.maxSize.height;

  static num get a => (AppTheme.w / AppTheme.dw) * (AppTheme.h / AppTheme.dh);
  static num get m =>
      min((AppTheme.w / AppTheme.dw), (AppTheme.h / AppTheme.dh));
  static num get s =>
      pow((AppTheme.w / AppTheme.dw) * (AppTheme.h / AppTheme.dh), 1 / 2);
  static num get c =>
      pow((AppTheme.w / AppTheme.dw) * (AppTheme.h / AppTheme.dh), 0.2);
  static num get maxs =>
      pow((AppTheme.mw / AppTheme.dw) * (AppTheme.mh / AppTheme.dh), 1 / 2);
  static num get maxc =>
      pow((AppTheme.mw / AppTheme.dw) * (AppTheme.mh / AppTheme.dh), 0.2);
  static num get rs => min(1, max(0, AppTheme.s - 1) / (AppTheme.maxs - 1));
  static num get rc => min(1, max(0, AppTheme.c - 1) / (AppTheme.maxc - 1));

  static TextTheme get tx => currentTheme.textTheme;

  ColorScheme buildColorScheme() {
    final surface = isDark
        ? const Color.fromARGB(255, 20, 20, 20)
        : Colors.white;
    final onSurface = isDark
        ? Colors.white
        : const Color.fromARGB(255, 60, 60, 60);

    final outline = isDark
        ? const Color.fromARGB(255, 117, 117, 117)
        : const Color.fromARGB(255, 208, 208, 208);

    return ColorScheme(
      brightness: isDark ? Brightness.dark : Brightness.light,

      primary: primary,
      onPrimary: primary.getOnColor(),
      inversePrimary: primary.lighten(isDark ? -.1 : .1),
      primaryContainer: primary,
      onPrimaryContainer: primary.getOnColor(),
      primaryFixed: primary,
      onPrimaryFixed: primary.getOnColor(),
      primaryFixedDim: primary,
      onPrimaryFixedVariant: primary.getOnColor(),

      secondary: secondary,
      onSecondary: secondary.getOnColor(),
      secondaryContainer: secondary,
      onSecondaryContainer: secondary.getOnColor(),
      secondaryFixed: secondary,
      onSecondaryFixed: secondary.getOnColor(),
      secondaryFixedDim: secondary,
      onSecondaryFixedVariant: secondary.getOnColor(),

      tertiary: tertiary,
      onTertiary: tertiary.getOnColor(),
      tertiaryContainer: tertiary,
      onTertiaryContainer: tertiary.getOnColor(),
      tertiaryFixed: tertiary,
      onTertiaryFixed: tertiary.getOnColor(),
      tertiaryFixedDim: tertiary,
      onTertiaryFixedVariant: tertiary.getOnColor(),

      surface: surface,
      onInverseSurface: surface,
      onSurface: onSurface,
      inverseSurface: onSurface,

      onSurfaceVariant: surface.lighten(isDark ? 0.6 : -0.6),
      surfaceTint: primary,

      error: isDark ? Color(0xffffb4ab) : Color.fromARGB(255, 238, 70, 70),
      onError: isDark ? Color(0xff690005) : Color(0xffffffff),
      errorContainer: isDark ? Color(0xff93000a) : Color(0xffffdad6),
      onErrorContainer: isDark ? Color(0xffffdad6) : Color(0xff93000a),

      outline: outline,
      outlineVariant: outline.lighten(isDark ? -.1 : .1),
      shadow: primary.lighten(isDark ? -.4 : 0.4),
      scrim: secondary.lighten(isDark ? -.4 : 0.4),

      surfaceContainerHighest: surface.lighten(isDark ? 0.02 : -0.02),
      surfaceContainerLow: surface.lighten(isDark ? 0.06 : -0.02),
      surfaceContainer: surface.lighten(isDark ? 0.08 : -0.03),
      surfaceContainerHigh: surface.lighten(isDark ? 0.04 : -0.03),
      surfaceBright: surface.lighten(isDark ? 0.02 : -0.02),
      surfaceContainerLowest: surface.lighten(isDark ? 0.04 : -0.03),
      surfaceDim: surface.lighten(isDark ? 0.08 : -0.03),
    );
  }

  TextTheme get textTheme {
    return TextTheme(
      //h0
      displayLarge: headlineTextStyle(
        TextStyle(letterSpacing: .5.c, fontSize: (42, 50).c),
      ),
      //h1
      displayMedium: headlineTextStyle(
        TextStyle(letterSpacing: .5.c, fontSize: (36, 42).c),
      ),
      //h2
      displaySmall: headlineTextStyle(
        TextStyle(letterSpacing: .5.c, fontSize: (32, 36).c),
      ),

      //h3
      headlineLarge: headlineTextStyle(
        TextStyle(letterSpacing: .5.c, fontSize: (26, 32).c),
      ),
      //h4
      headlineMedium: headlineTextStyle(
        TextStyle(letterSpacing: .5.c, fontSize: (22, 26).c),
      ),
      //h5
      headlineSmall: headlineTextStyle(TextStyle(fontSize: (19, 22).c)),

      //h6, Appbar
      titleLarge: bodyTextStyle(
        TextStyle(letterSpacing: 0.c, fontSize: (17, 19).c),
      ),

      //h7, CupertinoListTile, ListTile Title, Textfield label
      titleMedium: bodyTextStyle(
        TextStyle(
          letterSpacing: 1.c,
          fontSize: (15, 16).c,
          fontWeight: FontWeight.w400,
        ),
      ),

      //h8, Tabs
      titleSmall: bodyTextStyle(
        TextStyle(fontSize: (14, 14).c, fontWeight: FontWeight.w400),
      ),
      //TextFormField, CupertinoFormSection header, ListTile, SwitchTile, RadioTile
      bodyLarge: bodyTextStyle(TextStyle(fontSize: (14, 15).c)),

      //h9, Text,  Textfield font, Tile subtitle
      bodyMedium: bodyTextStyle(
        TextStyle(fontSize: (13, 14).c, fontWeight: FontWeight.w400),
      ),
      //Buttons
      labelLarge: bodyTextStyle(
        TextStyle(fontSize: (13, 14).c, fontWeight: FontWeight.w400),
      ),

      //p, ListTile subtitle, errortext
      bodySmall: bodyTextStyle(TextStyle(fontSize: (12, 13).c)),
      //BottomNavBar, Navigation
      labelMedium: bodyTextStyle(
        TextStyle(fontSize: (12, 13).c, fontWeight: FontWeight.w400),
      ),

      labelSmall: bodyTextStyle(
        TextStyle(fontSize: (10, 11).c, fontWeight: FontWeight.w400),
      ),
    );
  }

  ThemeData get theme {
    final colorScheme = themedata ?? buildColorScheme();

    return ThemeData(
      //
      useMaterial3: true,
      brightness: dark ? Brightness.dark : Brightness.light,
      colorScheme: colorScheme,
      textTheme: textTheme,

      //
      dividerTheme: DividerThemeData(),

      //
      inputDecorationTheme: InputDecorationTheme(
        border: !inputOutlined
            ? null
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius.c),
              ),
        filled: inputfilled,
        fillColor: colorScheme.surfaceContainerHigh,

        contentPadding: EdgeInsets.all(padding.c),
      ),

      // splashColor: ,
      appBarTheme: AppBarTheme(surfaceTintColor: Colors.white),

      //
      listTileTheme: ListTileThemeData(
        selectedTileColor: colorScheme.surfaceContainerHigh,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(borderRadius.c),
        // ),
      ),

      //
      // iconTheme: IconThemeData(), //Dont change
      iconButtonTheme: IconButtonThemeData(
        // style: IconButton.styleFrom(foregroundColor: colorScheme.onSurface),
      ),

      //
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.tertiary,
        foregroundColor: colorScheme.onTertiary,
      ),

      //
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.c),
          ),
          padding: EdgeInsets.all(padding.c),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.c),
          ),
          padding: EdgeInsets.all(padding.c),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.c),
          ),
          padding: EdgeInsets.all(padding.c),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(padding.c),
          foregroundColor: colorScheme.secondary,
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: colorScheme.onSurface,
        selectedItemColor: colorScheme.secondary,
        selectedLabelStyle: textTheme.bodySmall,
        unselectedLabelStyle: textTheme.bodySmall,
        selectedIconTheme: IconThemeData(size: 20),
        unselectedIconTheme: IconThemeData(size: 20),
        type: BottomNavigationBarType.fixed,
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
      ),

      tabBarTheme: TabBarThemeData(
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: BorderRadius.circular(24),
        ),
        labelStyle: textTheme.bodySmall.c(colorScheme.onSecondary),
        unselectedLabelStyle: textTheme.bodySmall,
        dividerColor: Colors.transparent,
      ),

      //
      dialogTheme: DialogThemeData(
        elevation: 2,
        actionsPadding: EdgeInsets.all(padding.c),
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.c),
          side: BorderSide.none,
        ),
      ),

      //
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.c),
          side: BorderSide.none,
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.secondary,
        circularTrackColor: colorScheme.surfaceContainerHighest,
        linearTrackColor: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(100),
      ),

      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.secondary,
        thumbColor: colorScheme.tertiary,
        padding: EdgeInsets.zero,
      ),
    );
  }

  @override
  String toString() {
    return 'AppTheme(size: $size, maxSize: $maxSize, designSize: $designSize, dark: $dark, primary: ${primary.hexCode}, secondary: ${secondary.hexCode}, tertiary: ${tertiary.hexCode})';
  }
}
