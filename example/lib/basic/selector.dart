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
      ],
    );
  }
}
