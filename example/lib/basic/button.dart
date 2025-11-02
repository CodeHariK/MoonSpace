import 'package:flutter/material.dart';

class ButtonView extends StatelessWidget {
  const ButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          runSpacing: 8,
          spacing: 4,
          children: <Widget>[
            Buttons(isDisabled: false, hasIcon: false),
            Buttons(isDisabled: false, hasIcon: true),
            Buttons(isDisabled: true, hasIcon: false),
          ],
        ),
        Wrap(
          runSpacing: 4,
          spacing: 4,
          children: [
            ActionChip(
              label: const Text('Assist'),
              avatar: const Icon(Icons.event),
              onPressed: () {},
            ),
            FilterChip(label: const Text('Filter'), selected: true, onSelected: (selected) {}),
            InputChip(label: const Text('Input'), onPressed: () {}, onDeleted: () {}),
          ],
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
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
        FloatingActionButtons(),
      ],
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
                : FilledButton(onPressed: isDisabled ? null : () {}, child: const Text('Filled')),
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
                : TextButton(onPressed: isDisabled ? null : () {}, child: const Text('Text')),
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
    return Card(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 4,
        spacing: 4,
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
