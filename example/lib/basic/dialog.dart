import 'package:example/basic/constant.dart';
import 'package:example/basic/decoration.dart';
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

        SnackBarSection(),
        BottomSheetSection(),
        Cards(),
      ],
    );
  }
}

class SnackBarSection extends StatelessWidget {
  const SnackBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Snackbar',
      tooltipMessage: 'Use ScaffoldMessenger.of(context).showSnackBar with SnackBar',
      child: TextButton(
        onPressed: () {
          final snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            width: 400.0,
            content: const Text('This is a snackbar'),
            action: SnackBarAction(label: 'Close', onPressed: () {}),
          );

          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Show snackbar', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class BottomSheetSection extends StatefulWidget {
  const BottomSheetSection({super.key});

  @override
  State<BottomSheetSection> createState() => _BottomSheetSectionState();
}

class _BottomSheetSectionState extends State<BottomSheetSection> {
  bool isNonModalBottomSheetOpen = false;
  PersistentBottomSheetController? _nonModalBottomSheetController;

  @override
  Widget build(BuildContext context) {
    List<Widget> buttonList = <Widget>[
      IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.archive_outlined)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
    ];
    List<Text> labelList = const <Text>[
      Text('Share'),
      Text('Add to'),
      Text('Trash'),
      Text('Archive'),
      Text('Settings'),
      Text('Favorite'),
    ];

    buttonList = List.generate(
      buttonList.length,
      (index) => Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [buttonList[index], labelList[index]],
        ),
      ),
    );

    return ComponentDecoration(
      label: 'Bottom sheet',
      tooltipMessage: 'Use showModalBottomSheet<T> or showBottomSheet<T>',
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        children: [
          TextButton(
            child: const Text(
              'Show modal bottom sheet',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                showDragHandle: true,
                context: context,
                // TODO: Remove when this is in the framework https://github.com/flutter/flutter/issues/118619
                constraints: const BoxConstraints(maxWidth: 640),
                builder: (context) {
                  return SizedBox(
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: buttonList,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          TextButton(
            child: Text(
              isNonModalBottomSheetOpen ? 'Hide bottom sheet' : 'Show bottom sheet',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              if (isNonModalBottomSheetOpen) {
                _nonModalBottomSheetController?.close();
                setState(() {
                  isNonModalBottomSheetOpen = false;
                });
                return;
              } else {
                setState(() {
                  isNonModalBottomSheetOpen = true;
                });
              }

              _nonModalBottomSheetController = showBottomSheet(
                elevation: 8.0,
                context: context,
                // TODO: Remove when this is in the framework https://github.com/flutter/flutter/issues/118619
                constraints: const BoxConstraints(maxWidth: 640),
                builder: (context) {
                  return SizedBox(
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: buttonList,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Cards',
      tooltipMessage: 'Use Card',
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: cardWidth,
            child: Card(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
                    ),
                    const SizedBox(height: 20),
                    const Align(alignment: Alignment.bottomLeft, child: Text('Elevated')),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: cardWidth,
            child: Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              elevation: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
                    ),
                    const SizedBox(height: 20),
                    const Align(alignment: Alignment.bottomLeft, child: Text('Filled')),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: cardWidth,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).colorScheme.outline),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
                    ),
                    const SizedBox(height: 20),
                    const Align(alignment: Alignment.bottomLeft, child: Text('Outlined')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
