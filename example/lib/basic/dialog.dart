import 'package:flutter/material.dart';

class DiaglogView extends StatelessWidget {
  const DiaglogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AlertDialog(
          title: const Text('What is a dialog?'),
          content: const Text(
            'A dialog is a type of modal window that appears in front of app content to provide critical information, or prompt for a decision to be made.',
          ),
          actions: <Widget>[
            OutlinedButton(
              child: const Text('Dismiss'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FilledButton(child: const Text('Okay'), onPressed: () => Navigator.of(context).pop()),
          ],
        ),

        MaterialBanner(
          content: const Text(
            'A dialog is a type of modal window that appears in front of app content to provide critical information, or prompt for a decision to be made.',
          ),
          actions: <Widget>[
            OutlinedButton(
              child: const Text('Dismiss'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FilledButton(child: const Text('Okay'), onPressed: () => Navigator.of(context).pop()),
          ],
        ),
      ],
    );
  }
}
