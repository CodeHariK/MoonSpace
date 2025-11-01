import 'package:flutter/material.dart';

class DropdownView extends StatefulWidget {
  const DropdownView({super.key});

  @override
  State<DropdownView> createState() => _DropdownViewState();
}

class _DropdownViewState extends State<DropdownView> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<String> entries = ["Smile", "Cloud", "Heart"];

    return Wrap(
      alignment: WrapAlignment.spaceAround,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      runSpacing: 4,
      children: [
        DropdownButton(
          hint: Text("Color"),
          // selectedItemBuilder: (context) {
          //   return [Text("Hello"), Text("Hi")];
          // },
          value: "Smile",
          items: entries.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (value) {},
        ),
        SizedBox(
          width: 150,
          child: DropdownButtonFormField(
            hint: Text("Color"),
            items: entries.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (value) {},
          ),
        ),
        DropdownMenu(
          controller: colorController,
          label: const Text('Color'),
          enableFilter: true,
          dropdownMenuEntries: entries
              .map((e) => DropdownMenuEntry<String>(value: e, label: e, enabled: e != 'Grey'))
              .toList(),
          inputDecorationTheme: const InputDecorationTheme(filled: true),
          onSelected: (color) {},
        ),
        DropdownMenu(
          initialSelection: "Smile",
          controller: iconController,
          leadingIcon: const Icon(Icons.search),
          label: const Text('Icon'),
          dropdownMenuEntries: entries
              .map((e) => DropdownMenuEntry<String>(value: e, label: e, enabled: e != 'Grey'))
              .toList(),
          onSelected: (icon) {},
        ),
      ],
    );
  }
}
