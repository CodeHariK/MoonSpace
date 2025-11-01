import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moonspace/theme.dart';

List<AppTheme> getAppThemes() => [
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
];
