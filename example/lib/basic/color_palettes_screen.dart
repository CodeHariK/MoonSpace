// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

const Widget divider = SizedBox(height: 10);

// If screen content width is greater or equal to this value, the light and dark
// color schemes will be displayed in a column. Otherwise, they will
// be displayed in a row.
const double narrowScreenWidthThreshold = 500;

// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class ColorBox extends StatefulWidget {
  const ColorBox({
    super.key,
    required this.label,
    required this.tone,
    required this.color,
    required this.onColor,
    required this.height,
    required this.width,
    this.displayPaletteInfo = false,
  });

  final String label;
  final String tone;
  final Color color, onColor;
  final double height, width;
  final bool displayPaletteInfo;

  @override
  State<ColorBox> createState() => _ColorBoxState();
}

class _ColorBoxState extends State<ColorBox> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final fonts = Theme.of(context).textTheme;
    return MouseRegion(
      onEnter: (_) {
        if (mounted) setState(() => hovered = true);
      },
      onExit: (_) {
        if (mounted) setState(() => hovered = false);
      },
      child: Container(
        color: widget.color,
        height: widget.height,
        width: widget.width,
        child: DefaultTextStyle(
          style: fonts.labelSmall!.copyWith(color: widget.onColor),
          child: Stack(
            children: [
              Positioned(top: 10, left: 10, child: Text(widget.label)),
              Positioned(
                bottom: 10,
                right: 10,
                child: Text(widget.displayPaletteInfo ? widget.tone : ''),
              ),
              if (hovered)
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    color: widget.onColor,
                    tooltip: 'Copy hex color',
                    icon: const Icon(Icons.copy, size: 24),
                    onPressed: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      // Copy color as hex to clipboard
                      final c = widget.color;

                      final hex =
                          '#${_colorChannelToHex(c.r)}'
                          '${_colorChannelToHex(c.g)}'
                          '${_colorChannelToHex(c.b)}';

                      final data = ClipboardData(text: hex);
                      await Clipboard.setData(data);
                      messenger.hideCurrentSnackBar();
                      messenger.showSnackBar(SnackBar(content: Text('Copied $hex to clipboard')));
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

String _colorChannelToHex(double value) {
  final intVal = (value * 255).round();
  return intVal.toRadixString(16).padLeft(2, '0');
}

class SchemePreview extends StatefulWidget {
  const SchemePreview({
    super.key,
    required this.label,
    required this.scheme,
    required this.brightness,
    required this.colorMatch,
    required this.contrast,
  });

  final String label;
  final ColorScheme scheme;
  final Brightness brightness;
  final bool colorMatch;
  final double contrast;

  @override
  State<SchemePreview> createState() => _SchemePreviewState();
}

class _SchemePreviewState extends State<SchemePreview> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fonts = theme.textTheme;
    final colors = theme.colorScheme;
    final dark = widget.brightness == Brightness.dark;

    final scheme = widget.scheme;

    return Theme(
      data: theme.copyWith(colorScheme: scheme),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Container(
          width: 902,
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.brightness == widget.brightness
                  ? colors.outlineVariant
                  : Colors.transparent,
            ),
          ),
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.label,
                      style: fonts.titleMedium!.copyWith(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ColorBox(
                                label: 'Primary',
                                tone: dark ? 'P-80' : 'P-40',
                                color: scheme.primary,
                                onColor: scheme.onPrimary,
                                height: 87,
                                width: 208,
                              ),
                              ColorBox(
                                label: 'On Primary',
                                tone: dark ? 'P-20' : 'P-100',
                                color: scheme.onPrimary,
                                onColor: scheme.primary,
                                height: 40,
                                width: 208,
                              ),
                              const SizedBox(height: 5),
                              ColorBox(
                                label: 'Primary Container',
                                tone: dark ? 'P-30' : 'P-90',
                                color: scheme.primaryContainer,
                                onColor: scheme.onPrimaryContainer,
                                height: 87,
                                width: 208,
                              ),
                              ColorBox(
                                label: 'On Primary Container',
                                tone: dark ? 'P-90' : 'P-10',
                                color: scheme.onPrimaryContainer,
                                onColor: scheme.primaryContainer,
                                height: 40,
                                width: 208,
                              ),
                            ],
                          ),
                          const SizedBox(width: 5),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ColorBox(
                                label: 'Secondary',
                                tone: dark ? 'S-80' : 'S-40',
                                color: scheme.secondary,
                                onColor: scheme.onSecondary,
                                height: 87,
                                width: 208,
                              ),
                              ColorBox(
                                label: 'On Secondary',
                                tone: dark ? 'S-20' : 'S-100',
                                color: scheme.onSecondary,
                                onColor: scheme.secondary,
                                height: 40,
                                width: 208,
                              ),
                              const SizedBox(height: 5),
                              ColorBox(
                                label: 'Secondary Container',
                                tone: dark ? 'S-30' : 'S-90',
                                color: scheme.secondaryContainer,
                                onColor: scheme.onSecondaryContainer,
                                height: 87,
                                width: 208,
                              ),
                              ColorBox(
                                label: 'On Secondary Container',
                                tone: dark ? 'S-90' : 'S-10',
                                color: scheme.onSecondaryContainer,
                                onColor: scheme.secondaryContainer,
                                height: 40,
                                width: 208,
                              ),
                            ],
                          ),
                          const SizedBox(width: 5),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ColorBox(
                                label: 'Tertiary',
                                tone: dark ? 'T-80' : 'T-40',
                                color: scheme.tertiary,
                                onColor: scheme.onTertiary,
                                height: 87,
                                width: 208,
                              ),
                              ColorBox(
                                label: 'On Tertiary',
                                tone: dark ? 'T-20' : 'T-100',
                                color: scheme.onTertiary,
                                onColor: scheme.tertiary,
                                height: 40,
                                width: 208,
                              ),
                              const SizedBox(height: 5),
                              ColorBox(
                                label: 'Tertiary Container',
                                tone: dark ? 'T-30' : 'T-90',
                                color: scheme.tertiaryContainer,
                                onColor: scheme.onTertiaryContainer,
                                height: 87,
                                width: 208,
                              ),
                              ColorBox(
                                label: 'On Tertiary Container',
                                tone: dark ? 'T-90' : 'T-10',
                                color: scheme.onTertiaryContainer,
                                onColor: scheme.tertiaryContainer,
                                height: 40,
                                width: 208,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ColorBox(
                            label: 'Surface Dim',
                            tone: dark ? 'N-6' : 'N-87',
                            color: scheme.surfaceDim,
                            onColor: scheme.onSurface,
                            height: 105,
                            width: 211.45,
                          ),
                          ColorBox(
                            label: 'Surface',
                            tone: dark ? 'N-6' : 'N-98',
                            color: scheme.surface,
                            onColor: scheme.onSurface,
                            height: 105,
                            width: 211.45,
                          ),
                          ColorBox(
                            label: 'Surface Bright',
                            tone: dark ? 'N-24' : 'N-98',
                            color: scheme.surfaceBright,
                            onColor: scheme.onSurface,
                            height: 105,
                            width: 211.45,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ColorBox(
                            label: 'Surf. Container\nLowest',
                            tone: dark ? 'N-4' : 'N-100',
                            color: scheme.surfaceContainerLowest,
                            onColor: scheme.onSurface,
                            height: 105,
                            width: 126.87,
                          ),
                          ColorBox(
                            label: 'Surf. Container\nLow',
                            tone: dark ? 'N-10' : 'N-96',
                            color: scheme.surfaceContainerLow,
                            onColor: scheme.onSurface,
                            height: 105,
                            width: 126.87,
                          ),
                          ColorBox(
                            label: 'Surf. Container',
                            tone: dark ? 'N-12' : 'N-94',
                            color: scheme.surfaceContainer,
                            onColor: scheme.onSurface,
                            height: 105,
                            width: 126.87,
                          ),
                          ColorBox(
                            label: 'Surf. Container\nHigh',
                            tone: dark ? 'N-17' : 'N-92',
                            color: scheme.surfaceContainerHigh,
                            onColor: scheme.onSurface,
                            height: 105,
                            width: 126.87,
                          ),
                          ColorBox(
                            label: 'Surf. Container\nHighest',
                            tone: dark ? 'N-24' : 'N-90',
                            color: scheme.surfaceContainerHighest,
                            onColor: scheme.onSurface,
                            height: 105,
                            width: 126.87,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ColorBox(
                            label: 'On Surface',
                            tone: dark ? 'N-90' : 'N-10',
                            color: scheme.onSurface,
                            onColor: scheme.surface,
                            height: 40,
                            width: 158.59,
                          ),
                          ColorBox(
                            label: 'On Surface Var.',
                            tone: dark ? 'NV-90' : 'NV-30',
                            color: scheme.onSurfaceVariant,
                            onColor: scheme.surfaceContainerHighest,
                            height: 40,
                            width: 158.59,
                          ),
                          ColorBox(
                            label: 'Outline',
                            tone: dark ? 'NV-60' : 'NV-50',
                            color: scheme.outline,
                            onColor: scheme.surface,
                            height: 40,
                            width: 158.59,
                          ),
                          ColorBox(
                            label: 'Outline Variant',
                            tone: dark ? 'NV-30' : 'NV-80',
                            color: scheme.outlineVariant,
                            onColor: scheme.onSurface,
                            height: 40,
                            width: 158.59,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ColorBox(
                        label: 'Error',
                        tone: dark ? 'E-80' : 'E-40',
                        color: scheme.error,
                        onColor: scheme.onError,
                        height: 87,
                        width: 208,
                      ),
                      ColorBox(
                        label: 'On Error',
                        tone: dark ? 'E-20' : 'E-100',
                        color: scheme.onError,
                        onColor: scheme.error,
                        height: 40,
                        width: 208,
                      ),
                      const SizedBox(height: 5),
                      ColorBox(
                        label: 'Error Container',
                        tone: dark ? 'E-30' : 'E-90',
                        color: scheme.errorContainer,
                        onColor: scheme.onErrorContainer,
                        height: 87,
                        width: 208,
                      ),
                      ColorBox(
                        label: 'On Error Container',
                        tone: dark ? 'E-90' : 'E-10',
                        color: scheme.onErrorContainer,
                        onColor: scheme.errorContainer,
                        height: 40,
                        width: 208,
                      ),
                      const SizedBox(height: 20),
                      ColorBox(
                        label: 'Inverse Surface',
                        tone: dark ? 'N-90' : 'N-20',
                        color: scheme.inverseSurface,
                        onColor: scheme.onInverseSurface,
                        height: 120,
                        width: 208,
                      ),
                      ColorBox(
                        label: 'Inverse On Surface',
                        tone: dark ? 'N-20' : 'N-95',
                        color: scheme.onInverseSurface,
                        onColor: scheme.inverseSurface,
                        height: 40,
                        width: 208,
                      ),
                      const SizedBox(height: 5),
                      ColorBox(
                        label: 'Inverse Primary',
                        tone: dark ? 'P-40' : 'P-80',
                        color: scheme.inversePrimary,
                        onColor: scheme.onSurface,
                        height: 40,
                        width: 208,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ColorBox(
                            label: 'Scrim',
                            tone: 'N-0',
                            color: scheme.scrim,
                            onColor: Colors.white,
                            height: 40,
                            width: 96.31,
                          ),
                          const SizedBox(width: 20),
                          ColorBox(
                            label: 'Shadow',
                            tone: 'N-0',
                            color: scheme.shadow,
                            onColor: Colors.white,
                            height: 40,
                            width: 96.31,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
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

class ColorPalettesScreen extends StatelessWidget {
  const ColorPalettesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color selectedColor = Theme.of(context).primaryColor;
    ThemeData lightTheme = ThemeData(colorSchemeSeed: selectedColor, brightness: Brightness.light);
    ThemeData darkTheme = ThemeData(colorSchemeSeed: selectedColor, brightness: Brightness.dark);

    Widget schemeLabel(String brightness) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(brightness, style: const TextStyle(fontWeight: FontWeight.bold)),
      );
    }

    Widget schemeView(ThemeData theme) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ColorSchemeView(colorScheme: theme.colorScheme),
      );
    }

    Widget dynamicColorNotice() => RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall,
        children: [
          const TextSpan(
            text:
                'To create color schemes based on a '
                'platform\'s implementation of dynamic color, '
                'use the ',
          ),
          TextSpan(
            text: 'dynamic_color',
            style: const TextStyle(decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final url = Uri.parse('https://pub.dev/packages/dynamic_color');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
          ),
          const TextSpan(text: ' package.'),
        ],
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < narrowScreenWidthThreshold) {
          return SingleChildScrollView(
            child: Column(
              children: [
                dynamicColorNotice(),
                divider,
                schemeLabel('Light ColorScheme'),
                schemeView(lightTheme),
                divider,
                divider,
                schemeLabel('Dark ColorScheme'),
                schemeView(darkTheme),
              ],
            ),
          );
        } else {
          Color seed = Theme.of(context).colorScheme.primary;
          ColorScheme lightScheme = ColorScheme.fromSeed(
            seedColor: seed,
            brightness: Brightness.light,
          );
          ColorScheme darkScheme = ColorScheme.fromSeed(
            seedColor: seed,
            brightness: Brightness.dark,
          );
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SchemePreview(
                    label: "Light ColorScheme",
                    scheme: lightScheme,
                    brightness: Brightness.light,
                    contrast: 1.0,
                    colorMatch: false,
                  ),
                  const SizedBox(height: 16),
                  SchemePreview(
                    label: "Dark ColorScheme",
                    scheme: darkScheme,
                    brightness: Brightness.dark,
                    contrast: 1.0,
                    colorMatch: false,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        }
      },
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
          children: [
            ColorChip(label: 'primary', color: colorScheme.primary, onColor: colorScheme.onPrimary),
            ColorChip(
              label: 'onPrimary',
              color: colorScheme.onPrimary,
              onColor: colorScheme.primary,
            ),
            ColorChip(
              label: 'primaryContainer',
              color: colorScheme.primaryContainer,
              onColor: colorScheme.onPrimaryContainer,
            ),
            ColorChip(
              label: 'onPrimaryContainer',
              color: colorScheme.onPrimaryContainer,
              onColor: colorScheme.primaryContainer,
            ),
          ],
        ),
        divider,
        ColorGroup(
          children: [
            ColorChip(
              label: 'primaryFixed',
              color: colorScheme.primaryFixed,
              onColor: colorScheme.onPrimaryFixed,
            ),
            ColorChip(
              label: 'onPrimaryFixed',
              color: colorScheme.onPrimaryFixed,
              onColor: colorScheme.primaryFixed,
            ),
            ColorChip(
              label: 'primaryFixedDim',
              color: colorScheme.primaryFixedDim,
              onColor: colorScheme.onPrimaryFixedVariant,
            ),
            ColorChip(
              label: 'onPrimaryFixedVariant',
              color: colorScheme.onPrimaryFixedVariant,
              onColor: colorScheme.primaryFixedDim,
            ),
          ],
        ),
        divider,
        ColorGroup(
          children: [
            ColorChip(
              label: 'secondary',
              color: colorScheme.secondary,
              onColor: colorScheme.onSecondary,
            ),
            ColorChip(
              label: 'onSecondary',
              color: colorScheme.onSecondary,
              onColor: colorScheme.secondary,
            ),
            ColorChip(
              label: 'secondaryContainer',
              color: colorScheme.secondaryContainer,
              onColor: colorScheme.onSecondaryContainer,
            ),
            ColorChip(
              label: 'onSecondaryContainer',
              color: colorScheme.onSecondaryContainer,
              onColor: colorScheme.secondaryContainer,
            ),
          ],
        ),
        divider,
        ColorGroup(
          children: [
            ColorChip(
              label: 'secondaryFixed',
              color: colorScheme.secondaryFixed,
              onColor: colorScheme.onSecondaryFixed,
            ),
            ColorChip(
              label: 'onSecondaryFixed',
              color: colorScheme.onSecondaryFixed,
              onColor: colorScheme.secondaryFixed,
            ),
            ColorChip(
              label: 'secondaryFixedDim',
              color: colorScheme.secondaryFixedDim,
              onColor: colorScheme.onSecondaryFixedVariant,
            ),
            ColorChip(
              label: 'onSecondaryFixedVariant',
              color: colorScheme.onSecondaryFixedVariant,
              onColor: colorScheme.secondaryFixedDim,
            ),
          ],
        ),
        divider,
        ColorGroup(
          children: [
            ColorChip(
              label: 'tertiary',
              color: colorScheme.tertiary,
              onColor: colorScheme.onTertiary,
            ),
            ColorChip(
              label: 'onTertiary',
              color: colorScheme.onTertiary,
              onColor: colorScheme.tertiary,
            ),
            ColorChip(
              label: 'tertiaryContainer',
              color: colorScheme.tertiaryContainer,
              onColor: colorScheme.onTertiaryContainer,
            ),
            ColorChip(
              label: 'onTertiaryContainer',
              color: colorScheme.onTertiaryContainer,
              onColor: colorScheme.tertiaryContainer,
            ),
          ],
        ),
        divider,
        ColorGroup(
          children: [
            ColorChip(
              label: 'tertiaryFixed',
              color: colorScheme.tertiaryFixed,
              onColor: colorScheme.onTertiaryFixed,
            ),
            ColorChip(
              label: 'onTertiaryFixed',
              color: colorScheme.onTertiaryFixed,
              onColor: colorScheme.tertiaryFixed,
            ),
            ColorChip(
              label: 'tertiaryFixedDim',
              color: colorScheme.tertiaryFixedDim,
              onColor: colorScheme.onTertiaryFixedVariant,
            ),
            ColorChip(
              label: 'onTertiaryFixedVariant',
              color: colorScheme.onTertiaryFixedVariant,
              onColor: colorScheme.tertiaryFixedDim,
            ),
          ],
        ),
        divider,
        ColorGroup(
          children: [
            ColorChip(label: 'error', color: colorScheme.error, onColor: colorScheme.onError),
            ColorChip(label: 'onError', color: colorScheme.onError, onColor: colorScheme.error),
            ColorChip(
              label: 'errorContainer',
              color: colorScheme.errorContainer,
              onColor: colorScheme.onErrorContainer,
            ),
            ColorChip(
              label: 'onErrorContainer',
              color: colorScheme.onErrorContainer,
              onColor: colorScheme.errorContainer,
            ),
          ],
        ),
        divider,
        ColorGroup(
          children: [
            ColorChip(
              label: 'surfaceDim',
              color: colorScheme.surfaceDim,
              onColor: colorScheme.onSurface,
            ),
            ColorChip(label: 'surface', color: colorScheme.surface, onColor: colorScheme.onSurface),
            ColorChip(
              label: 'surfaceBright',
              color: colorScheme.surfaceBright,
              onColor: colorScheme.onSurface,
            ),
            ColorChip(
              label: 'surfaceContainerLowest',
              color: colorScheme.surfaceContainerLowest,
              onColor: colorScheme.onSurface,
            ),
            ColorChip(
              label: 'surfaceContainerLow',
              color: colorScheme.surfaceContainerLow,
              onColor: colorScheme.onSurface,
            ),
            ColorChip(
              label: 'surfaceContainer',
              color: colorScheme.surfaceContainer,
              onColor: colorScheme.onSurface,
            ),
            ColorChip(
              label: 'surfaceContainerHigh',
              color: colorScheme.surfaceContainerHigh,
              onColor: colorScheme.onSurface,
            ),
            ColorChip(
              label: 'surfaceContainerHighest',
              color: colorScheme.surfaceContainerHighest,
              onColor: colorScheme.onSurface,
            ),
            ColorChip(
              label: 'onSurface',
              color: colorScheme.onSurface,
              onColor: colorScheme.surface,
            ),
            ColorChip(
              label: 'onSurfaceVariant',
              color: colorScheme.onSurfaceVariant,
              onColor: colorScheme.surfaceContainerHighest,
            ),
          ],
        ),
        divider,
        ColorGroup(
          children: [
            ColorChip(label: 'outline', color: colorScheme.outline, onColor: null),
            ColorChip(label: 'shadow', color: colorScheme.shadow, onColor: null),
            ColorChip(
              label: 'inverseSurface',
              color: colorScheme.inverseSurface,
              onColor: colorScheme.onInverseSurface,
            ),
            ColorChip(
              label: 'onInverseSurface',
              color: colorScheme.onInverseSurface,
              onColor: colorScheme.inverseSurface,
            ),
            ColorChip(
              label: 'inversePrimary',
              color: colorScheme.inversePrimary,
              onColor: colorScheme.primary,
            ),
          ],
        ),
      ],
    );
  }
}

class ColorGroup extends StatelessWidget {
  const ColorGroup({super.key, required this.children});

  final List<ColorChip> children;

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
  const ColorChip({super.key, required this.color, required this.label, this.onColor});

  final Color color;
  final Color? onColor;
  final String label;

  static Color contrastColor(Color color) => switch (ThemeData.estimateBrightnessForColor(color)) {
    Brightness.dark => Colors.white,
    Brightness.light => Colors.black,
  };

  @override
  Widget build(BuildContext context) {
    final Color labelColor = onColor ?? contrastColor(color);

    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(label, style: TextStyle(color: labelColor)),
            ),
          ],
        ),
      ),
    );
  }
}
