import 'package:example/basic/constant.dart';
import 'package:example/basic/decoration.dart';
import 'package:flutter/material.dart';

class ButtonView extends StatelessWidget {
  const ButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Actions(),
        // Wrap(
        //   runSpacing: 8,
        //   spacing: 4,
        //   children: <Widget>[
        //     Buttons(isDisabled: false, hasIcon: false),
        //     Buttons(isDisabled: false, hasIcon: true),
        //     Buttons(isDisabled: true, hasIcon: false),
        //   ],
        // ),
        // Wrap(
        //   runSpacing: 4,
        //   spacing: 4,
        //   children: [
        //     ActionChip(
        //       label: const Text('Assist'),
        //       avatar: const Icon(Icons.event),
        //       onPressed: () {},
        //     ),
        //     FilterChip(label: const Text('Filter'), selected: true, onSelected: (selected) {}),
        //     InputChip(label: const Text('Input'), onPressed: () {}, onDeleted: () {}),
        //   ],
        // ),
        // SizedBox(height: 8),
        // Wrap(
        //   spacing: 8,
        //   children: [
        //     IconButton.filled(
        //       icon: const Icon(Icons.settings_outlined),
        //       selectedIcon: const Icon(Icons.settings),
        //       onPressed: () {},
        //     ),
        //     IconButton.filledTonal(
        //       icon: const Icon(Icons.settings_outlined),
        //       selectedIcon: const Icon(Icons.settings),
        //       onPressed: () {},
        //     ),
        //     IconButton.outlined(
        //       icon: const Icon(Icons.settings_outlined),
        //       selectedIcon: const Icon(Icons.settings),
        //       onPressed: () {},
        //     ),
        //     IconButton(
        //       icon: const Icon(Icons.settings_outlined),
        //       selectedIcon: const Icon(Icons.settings),
        //       onPressed: () {},
        //     ),
        //     IconButton.filled(
        //       isSelected: true,
        //       icon: const Icon(Icons.settings_outlined),
        //       selectedIcon: const Icon(Icons.settings),
        //       onPressed: () {},
        //     ),
        //     IconButton.filledTonal(
        //       isSelected: true,
        //       icon: const Icon(Icons.settings_outlined),
        //       selectedIcon: const Icon(Icons.settings),
        //       onPressed: () {},
        //     ),
        //     IconButton.outlined(
        //       isSelected: true,
        //       icon: const Icon(Icons.settings_outlined),
        //       selectedIcon: const Icon(Icons.settings),
        //       onPressed: () {},
        //     ),
        //     IconButton(
        //       isSelected: true,
        //       icon: const Icon(Icons.settings_outlined),
        //       selectedIcon: const Icon(Icons.settings),
        //       onPressed: () {},
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

// class Buttons extends StatelessWidget {
//   final bool isDisabled;
//   final bool hasIcon;

//   const Buttons({super.key, required this.isDisabled, required this.hasIcon});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: IntrinsicWidth(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             hasIcon
//                 ? ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: const Icon(Icons.add),
//                     label: const Text('Icon'),
//                   )
//                 : ElevatedButton(
//                     onPressed: isDisabled ? null : () {},
//                     child: const Text('Elevated'),
//                   ),
//             hasIcon
//                 ? FilledButton.icon(
//                     onPressed: () {},
//                     label: const Text('Icon'),
//                     icon: const Icon(Icons.add),
//                   )
//                 : FilledButton(onPressed: isDisabled ? null : () {}, child: const Text('Filled')),
//             hasIcon
//                 ? FilledButton.tonalIcon(
//                     onPressed: () {},
//                     label: const Text('Icon'),
//                     icon: const Icon(Icons.add),
//                   )
//                 : FilledButton.tonal(
//                     onPressed: isDisabled ? null : () {},
//                     child: const Text('Filled tonal'),
//                   ),
//             hasIcon
//                 ? OutlinedButton.icon(
//                     onPressed: () {},
//                     icon: const Icon(Icons.add),
//                     label: const Text('Icon'),
//                   )
//                 : OutlinedButton(
//                     onPressed: isDisabled ? null : () {},
//                     child: const Text('Outlined'),
//                   ),

//             hasIcon
//                 ? TextButton.icon(
//                     onPressed: () {},
//                     icon: const Icon(Icons.add),
//                     label: const Text('Icon'),
//                   )
//                 : TextButton(onPressed: isDisabled ? null : () {}, child: const Text('Text')),
//           ],
//         ),
//       ),
//     );
//   }
// }

class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentGroupDecoration(
      label: 'Actions',
      children: <Widget>[
        Buttons(),
        FloatingActionButtons(),
        IconToggleButtons(),
        SegmentedButtons(),
      ],
    );
  }
}

class Buttons extends StatefulWidget {
  const Buttons({super.key});

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return const ComponentDecoration(
      label: 'Common buttons',
      tooltipMessage:
          'Use ElevatedButton, FilledButton, FilledButton.tonal, OutlinedButton, or TextButton',
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ButtonsWithoutIcon(isDisabled: false),
            ButtonsWithIcon(),
            ButtonsWithoutIcon(isDisabled: true),
          ],
        ),
      ),
    );
  }
}

class ButtonsWithoutIcon extends StatelessWidget {
  final bool isDisabled;

  const ButtonsWithoutIcon({super.key, required this.isDisabled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(onPressed: isDisabled ? null : () {}, child: const Text('Elevated')),
            colDivider,
            FilledButton(onPressed: isDisabled ? null : () {}, child: const Text('Filled')),
            colDivider,
            FilledButton.tonal(
              onPressed: isDisabled ? null : () {},
              child: const Text('Filled tonal'),
            ),
            colDivider,
            OutlinedButton(onPressed: isDisabled ? null : () {}, child: const Text('Outlined')),
            colDivider,
            TextButton(onPressed: isDisabled ? null : () {}, child: const Text('Text')),
          ],
        ),
      ),
    );
  }
}

class ButtonsWithIcon extends StatelessWidget {
  const ButtonsWithIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Icon'),
            ),
            colDivider,
            FilledButton.icon(
              onPressed: () {},
              label: const Text('Icon'),
              icon: const Icon(Icons.add),
            ),
            colDivider,
            FilledButton.tonalIcon(
              onPressed: () {},
              label: const Text('Icon'),
              icon: const Icon(Icons.add),
            ),
            colDivider,
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Icon'),
            ),
            colDivider,
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Icon'),
            ),
          ],
        ),
      ),
    );
  }
}

class FloatingActionButtons extends StatelessWidget {
  const FloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Floating action buttons',
      tooltipMessage: 'Use FloatingActionButton or FloatingActionButton.extended',
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: smallSpacing,
        spacing: smallSpacing,
        children: [
          FloatingActionButton.small(
            onPressed: () {},
            tooltip: 'Small',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton.extended(
            onPressed: () {},
            tooltip: 'Extended',
            icon: const Icon(Icons.add),
            label: const Text('Create'),
          ),
          FloatingActionButton(onPressed: () {}, tooltip: 'Standard', child: const Icon(Icons.add)),
          FloatingActionButton.large(
            onPressed: () {},
            tooltip: 'Large',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class IconToggleButtons extends StatefulWidget {
  const IconToggleButtons({super.key});

  @override
  State<IconToggleButtons> createState() => _IconToggleButtonsState();
}

class _IconToggleButtonsState extends State<IconToggleButtons> {
  bool standardSelected = false;
  bool filledSelected = false;
  bool tonalSelected = false;
  bool outlinedSelected = false;

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Icon buttons',
      tooltipMessage:
          'Use IconButton, IconButton.filled, IconButton.filledTonal, and IconButton.outlined',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            // Standard IconButton
            children: <Widget>[
              IconButton(
                isSelected: standardSelected,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                onPressed: () {
                  setState(() {
                    standardSelected = !standardSelected;
                  });
                },
              ),
              colDivider,
              IconButton(
                isSelected: standardSelected,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                onPressed: null,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              // Filled IconButton
              IconButton.filled(
                isSelected: filledSelected,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                onPressed: () {
                  setState(() {
                    filledSelected = !filledSelected;
                  });
                },
              ),
              colDivider,
              IconButton.filled(
                isSelected: filledSelected,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                onPressed: null,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              // Filled Tonal IconButton
              IconButton.filledTonal(
                isSelected: tonalSelected,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                onPressed: () {
                  setState(() {
                    tonalSelected = !tonalSelected;
                  });
                },
              ),
              colDivider,
              IconButton.filledTonal(
                isSelected: tonalSelected,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                onPressed: null,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              // Outlined IconButton
              IconButton.outlined(
                isSelected: outlinedSelected,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                onPressed: () {
                  setState(() {
                    outlinedSelected = !outlinedSelected;
                  });
                },
              ),
              colDivider,
              IconButton.outlined(
                isSelected: outlinedSelected,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                onPressed: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SegmentedButtons extends StatelessWidget {
  const SegmentedButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentDecoration(
      label: 'Segmented buttons',
      tooltipMessage: 'Use SegmentedButton<T>',
      child: Column(children: <Widget>[SingleChoice(), colDivider, MultipleChoice()]),
    );
  }
}

enum Calendar { day, week, month, year }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  Calendar calendarView = Calendar.day;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Calendar>(
      segments: const <ButtonSegment<Calendar>>[
        ButtonSegment<Calendar>(
          value: Calendar.day,
          label: Text('Day'),
          icon: Icon(Icons.calendar_view_day),
        ),
        ButtonSegment<Calendar>(
          value: Calendar.week,
          label: Text('Week'),
          icon: Icon(Icons.calendar_view_week),
        ),
        ButtonSegment<Calendar>(
          value: Calendar.month,
          label: Text('Month'),
          icon: Icon(Icons.calendar_view_month),
        ),
        ButtonSegment<Calendar>(
          value: Calendar.year,
          label: Text('Year'),
          icon: Icon(Icons.calendar_today),
        ),
      ],
      selected: <Calendar>{calendarView},
      onSelectionChanged: (newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          calendarView = newSelection.first;
        });
      },
    );
  }
}

enum Sizes { extraSmall, small, medium, large, extraLarge }

class MultipleChoice extends StatefulWidget {
  const MultipleChoice({super.key});

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  Set<Sizes> selection = <Sizes>{Sizes.large, Sizes.extraLarge};

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Sizes>(
      segments: const <ButtonSegment<Sizes>>[
        ButtonSegment<Sizes>(value: Sizes.extraSmall, label: Text('XS')),
        ButtonSegment<Sizes>(value: Sizes.small, label: Text('S')),
        ButtonSegment<Sizes>(value: Sizes.medium, label: Text('M')),
        ButtonSegment<Sizes>(value: Sizes.large, label: Text('L')),
        ButtonSegment<Sizes>(value: Sizes.extraLarge, label: Text('XL')),
      ],
      selected: selection,
      onSelectionChanged: (newSelection) {
        setState(() {
          selection = newSelection;
        });
      },
      multiSelectionEnabled: true,
    );
  }
}
