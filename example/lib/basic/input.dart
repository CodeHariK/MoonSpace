import 'package:flutter/material.dart';

class InputView extends StatelessWidget {
  const InputView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(max: 100, divisions: 5, value: 30, label: "30", onChanged: (value) {}),
        SizedBox(height: 8),
        LinearProgressIndicator(
          value: .5,
          minHeight: 10,
          // color: purple,
          borderRadius: BorderRadius.circular(8),
        ),
      ],
    );
  }
}
