import 'package:example/basic/constant.dart';
import 'package:example/basic/decoration.dart';
import 'package:flutter/material.dart';
import 'package:moonspace/form/select.dart';

class SelectorView extends StatelessWidget {
  const SelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  Option(
                    title: Text("Title"),
                    value: "Witch",
                    subtitle: Text("Sub"),
                    icon: Icon(Icons.grass_outlined),
                  ),
                  Option(value: "Wizard"),
                  Option(value: "Sorceror", disabled: true, selected: true),
                ],
              ),
            ),
            Flexible(
              child: OptionBox(
                options: [
                  Option(
                    title: Text("Title"),
                    value: "Witch",
                    subtitle: Text("Sub"),
                    icon: Icon(Icons.grass_outlined),
                    selected: true,
                  ),
                  Option(value: "Wizard"),
                  Option(value: "Sorceror", disabled: true, selected: true),
                ],
                multi: true,
              ),
            ),
          ],
        ),

        Divider(),

        Row(
          children: [
            Flexible(
              child: OptionBox(
                options: [
                  Option(
                    title: Text("Title"),
                    value: "Witch",
                    subtitle: Text("Sub"),
                    icon: Icon(Icons.grass_outlined),
                  ),
                  Option(value: "Wizard"),
                  Option(value: "Sorceror", disabled: true, selected: true),
                ],
                multi: false,
                display: OptionDisplay.switchTile,
                divider: true,
              ),
            ),

            Flexible(
              child: OptionBox(
                options: [
                  Option(
                    title: Text("Title"),
                    value: "Witch",
                    subtitle: Text("Sub"),
                    icon: Icon(Icons.grass_outlined),
                  ),
                  Option(value: "Wizard"),
                  Option(value: "Sorceror", disabled: true, selected: true),
                ],
                display: OptionDisplay.chip,
              ),
            ),
          ],
        ),
        Selection(),
      ],
    );
  }
}

class Selection extends StatelessWidget {
  const Selection({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentGroupDecoration(
      label: 'Selection',
      children: [Chips(), Menus(), Sliders(), ProgressIndicators(), Switches()],
    );
  }
}

class Chips extends StatefulWidget {
  const Chips({super.key});

  @override
  State<Chips> createState() => _ChipsState();
}

class _ChipsState extends State<Chips> {
  bool isFiltered = true;

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Chips',
      tooltipMessage:
          'Use ActionChip, FilterChip, or InputChip. \nActionChip can also be used for suggestion chip',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Wrap(
            spacing: smallSpacing,
            runSpacing: smallSpacing,
            children: <Widget>[
              ActionChip(
                label: const Text('Assist'),
                avatar: const Icon(Icons.event),
                onPressed: () {},
              ),
              FilterChip(
                label: const Text('Filter'),
                selected: isFiltered,
                onSelected: (selected) {
                  setState(() => isFiltered = selected);
                },
              ),
              InputChip(label: const Text('Input'), onPressed: () {}, onDeleted: () {}),
              ActionChip(label: const Text('Suggestion'), onPressed: () {}),
            ],
          ),
          colDivider,
          Wrap(
            spacing: smallSpacing,
            runSpacing: smallSpacing,
            children: <Widget>[
              const ActionChip(label: Text('Assist'), avatar: Icon(Icons.event)),
              FilterChip(label: const Text('Filter'), selected: isFiltered, onSelected: null),
              InputChip(label: const Text('Input'), onDeleted: () {}, isEnabled: false),
              const ActionChip(label: Text('Suggestion')),
            ],
          ),
        ],
      ),
    );
  }
}

class Menus extends StatefulWidget {
  const Menus({super.key});

  @override
  State<Menus> createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  IconLabel? selectedIcon = IconLabel.smile;
  ColorLabel? selectedColor;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ColorLabel>> colorEntries = <DropdownMenuEntry<ColorLabel>>[];
    for (final ColorLabel color in ColorLabel.values) {
      colorEntries.add(
        DropdownMenuEntry<ColorLabel>(
          value: color,
          label: color.label,
          enabled: color.label != 'Grey',
        ),
      );
    }

    final List<DropdownMenuEntry<IconLabel>> iconEntries = <DropdownMenuEntry<IconLabel>>[];
    for (final IconLabel icon in IconLabel.values) {
      iconEntries.add(DropdownMenuEntry<IconLabel>(value: icon, label: icon.label));
    }

    return ComponentDecoration(
      label: 'Menus',
      tooltipMessage: 'Use MenuAnchor or DropdownMenu<T>',
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.spaceAround,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: smallSpacing,
            runSpacing: smallSpacing,
            children: [
              DropdownMenu<ColorLabel>(
                controller: colorController,
                label: const Text('Color'),
                enableFilter: true,
                dropdownMenuEntries: colorEntries,
                inputDecorationTheme: const InputDecorationTheme(filled: true),
                onSelected: (color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
              ),
              DropdownMenu<IconLabel>(
                initialSelection: IconLabel.smile,
                controller: iconController,
                leadingIcon: const Icon(Icons.search),
                label: const Text('Icon'),
                dropdownMenuEntries: iconEntries,
                onSelected: (icon) {
                  setState(() {
                    selectedIcon = icon;
                  });
                },
              ),
              Icon(selectedIcon?.icon, color: selectedColor?.color ?? Colors.grey.withAlpha(128)),
            ],
          ),
        ],
      ),
    );
  }
}

class Sliders extends StatefulWidget {
  const Sliders({super.key});

  @override
  State<Sliders> createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
  double sliderValue0 = 30.0;
  double sliderValue1 = 20.0;

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Sliders',
      tooltipMessage: 'Use Slider or RangeSlider',
      child: Column(
        children: <Widget>[
          Slider(
            max: 100,
            value: sliderValue0,
            onChanged: (value) {
              setState(() {
                sliderValue0 = value;
              });
            },
          ),
          const SizedBox(height: 20),
          Slider(
            max: 100,
            divisions: 5,
            value: sliderValue1,
            label: sliderValue1.round().toString(),
            onChanged: (value) {
              setState(() {
                sliderValue1 = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class Switches extends StatelessWidget {
  const Switches({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentDecoration(
      label: 'Switches',
      tooltipMessage: 'Use SwitchListTile or Switch',
      child: Column(children: <Widget>[SwitchRow(isEnabled: true), SwitchRow(isEnabled: false)]),
    );
  }
}

class SwitchRow extends StatefulWidget {
  const SwitchRow({super.key, required this.isEnabled});

  final bool isEnabled;

  @override
  State<SwitchRow> createState() => _SwitchRowState();
}

class _SwitchRowState extends State<SwitchRow> {
  bool value0 = false;
  bool value1 = true;

  final WidgetStateProperty<Icon?> thumbIcon = WidgetStateProperty.resolveWith<Icon?>((states) {
    if (states.contains(WidgetState.selected)) {
      return const Icon(Icons.check);
    }
    return const Icon(Icons.close);
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // TODO: use SwitchListTile when thumbIcon is available https://github.com/flutter/flutter/issues/118616
        Switch(
          value: value0,
          onChanged: widget.isEnabled
              ? (value) {
                  setState(() {
                    value0 = value;
                  });
                }
              : null,
        ),
        Switch(
          thumbIcon: thumbIcon,
          value: value1,
          onChanged: widget.isEnabled
              ? (value) {
                  setState(() {
                    value1 = value;
                  });
                }
              : null,
        ),
      ],
    );
  }
}

class ProgressIndicators extends StatefulWidget {
  const ProgressIndicators({super.key});

  @override
  State<ProgressIndicators> createState() => _ProgressIndicatorsState();
}

class _ProgressIndicatorsState extends State<ProgressIndicators> {
  bool playProgressIndicator = false;

  @override
  Widget build(BuildContext context) {
    final double? progressValue = playProgressIndicator ? null : 0.7;

    return ComponentDecoration(
      label: 'Progress indicators',
      tooltipMessage: 'Use CircularProgressIndicator or LinearProgressIndicator',
      child: Column(
        children: <Widget>[
          Row(
            children: [
              IconButton(
                isSelected: playProgressIndicator,
                selectedIcon: const Icon(Icons.pause),
                icon: const Icon(Icons.play_arrow),
                onPressed: () {
                  setState(() {
                    playProgressIndicator = !playProgressIndicator;
                  });
                },
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    rowDivider,
                    CircularProgressIndicator(value: progressValue),
                    rowDivider,
                    Expanded(child: LinearProgressIndicator(value: progressValue)),
                    rowDivider,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud('Cloud', Icons.cloud_outlined),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}
