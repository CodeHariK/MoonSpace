import 'package:flutter/material.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';

const Widget divider = SizedBox(height: 10);

class ColorSchemeExample extends StatefulWidget {
  const ColorSchemeExample({super.key, this.showScaffold = true});

  final bool showScaffold;

  @override
  State<ColorSchemeExample> createState() => _ColorSchemeExampleState();
}

class _ColorSchemeExampleState extends State<ColorSchemeExample> {
  static const List<DynamicSchemeVariant> schemeVariants = DynamicSchemeVariant.values;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ColorSchemeVariantColumn(
                    colorScheme: context.cs,
                    selectedColor: context.cPri,
                    brightness: context.brightness,
                    schemeVariant: schemeVariants[0],
                  ),
                  ...List<Widget>.generate(schemeVariants.length, (int index) {
                    return ColorSchemeVariantColumn(
                      selectedColor: context.cPri,
                      brightness: context.brightness,
                      schemeVariant: schemeVariants[index],
                    );
                  }),
                ],
              ),
            ),
          ],
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
    required this.selectedColor,
    this.colorScheme,
  });

  final DynamicSchemeVariant schemeVariant;
  final Brightness brightness;
  final Color selectedColor;

  final ColorScheme? colorScheme;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 180),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              schemeVariant.name == 'tonalSpot'
                  ? '${schemeVariant.name} (Default)'
                  : schemeVariant.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: ColorSchemeView(
              colorScheme:
                  colorScheme ??
                  ColorScheme.fromSeed(
                    seedColor: selectedColor,
                    brightness: brightness,
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
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ColorGroup(
          children: <ColorChip>[
            ColorChip('primary', colorScheme.primary),
            ColorChip('onPrimary', colorScheme.onPrimary),
            ColorChip('primaryContainer', colorScheme.primaryContainer),
            ColorChip('onPrimaryContainer', colorScheme.onPrimaryContainer),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip('primaryFixed', colorScheme.primaryFixed),
            ColorChip('onPrimaryFixed', colorScheme.onPrimaryFixed),
            ColorChip('primaryFixedDim', colorScheme.primaryFixedDim),
            ColorChip('onPrimaryFixedVariant', colorScheme.onPrimaryFixedVariant),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip('secondary', colorScheme.secondary),
            ColorChip('onSecondary', colorScheme.onSecondary),
            ColorChip('secondaryContainer', colorScheme.secondaryContainer),
            ColorChip('onSecondaryContainer', colorScheme.onSecondaryContainer),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip('secondaryFixed', colorScheme.secondaryFixed),
            ColorChip('onSecondaryFixed', colorScheme.onSecondaryFixed),
            ColorChip('secondaryFixedDim', colorScheme.secondaryFixedDim),
            ColorChip('onSecondaryFixedVariant', colorScheme.onSecondaryFixedVariant),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip('tertiary', colorScheme.tertiary),
            ColorChip('onTertiary', colorScheme.onTertiary),
            ColorChip('tertiaryContainer', colorScheme.tertiaryContainer),
            ColorChip('onTertiaryContainer', colorScheme.onTertiaryContainer),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip('tertiaryFixed', colorScheme.tertiaryFixed),
            ColorChip('onTertiaryFixed', colorScheme.onTertiaryFixed),
            ColorChip('tertiaryFixedDim', colorScheme.tertiaryFixedDim),
            ColorChip('onTertiaryFixedVariant', colorScheme.onTertiaryFixedVariant),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip('error', colorScheme.error),
            ColorChip('onError', colorScheme.onError),
            ColorChip('errorContainer', colorScheme.errorContainer),
            ColorChip('onErrorContainer', colorScheme.onErrorContainer),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip('surface', colorScheme.surface),
            ColorChip('surfaceBright', colorScheme.surfaceBright),
            ColorChip('surfaceContainerLowest', colorScheme.surfaceContainerLowest),
            ColorChip('surfaceContainerLow', colorScheme.surfaceContainerLow),
            ColorChip('surfaceContainer', colorScheme.surfaceContainer),
            ColorChip('surfaceContainerHigh', colorScheme.surfaceContainerHigh),
            ColorChip('surfaceContainerHighest', colorScheme.surfaceContainerHighest),
            ColorChip('surfaceDim', colorScheme.surfaceDim),

            ColorChip('onSurface', colorScheme.onSurface),
            ColorChip('onSurfaceVariant', colorScheme.onSurfaceVariant),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip('outline', colorScheme.outline),
            ColorChip('shadow', colorScheme.shadow),
            ColorChip('inverseSurface', colorScheme.inverseSurface),
            ColorChip('onInverseSurface', colorScheme.onInverseSurface),
            ColorChip('inversePrimary', colorScheme.inversePrimary),
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
        child: Column(mainAxisSize: MainAxisSize.min, children: children),
      ),
    );
  }
}

class ColorChip extends StatelessWidget {
  const ColorChip(this.label, this.color, {super.key});

  final Color color;
  final String label;

  static Color contrastColor(Color color) {
    final Brightness brightness = ThemeData.estimateBrightnessForColor(color);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(label, style: TextStyle(color: Colors.red, fontSize: 11)),
            ),
          ],
        ),
      ),
    );
  }
}
