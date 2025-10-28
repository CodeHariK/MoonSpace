import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moonspace/helper/stream/debounce.dart';
import 'package:moonspace/node_editor/links.dart';
import 'package:moonspace/node_editor/types.dart';

class NodeEditor extends StatefulWidget {
  const NodeEditor({super.key});

  @override
  State<NodeEditor> createState() => _NodeEditorState();
}

class _NodeEditorState extends State<NodeEditor> {
  late TransformationController _controller;
  bool _listenerAttached = false;

  final GlobalKey _viewerKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _controller = EditorNotifier.of(context).interactiveController;

    final editor = EditorNotifier.of(context);

    if (!_listenerAttached) {
      editor.editorRebuildStream = createThrottleDebounceFunc(200, (d) {
        editor.notifyEditor();
      }, leading: false);

      final matrix = Matrix4.identity()
        ..translate(-editor.ioffset.dx, -editor.ioffset.dy)
        ..scale(editor.izoom);
      _controller.value = matrix;

      _controller.addListener(() {
        final matrix = _controller.value;
        final zoom = matrix.getMaxScaleOnAxis();
        final offset = Offset(matrix.row0[3], matrix.row1[3]);
        editor.updateInteractiveZoom(zoom);
        editor.updateInteractiveOffset(offset);
      });

      // Future.delayed(Duration(milliseconds: 100), () {
      //   editor.notifyEditor();
      // });

      _listenerAttached = true;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = _viewerKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        editor.editorOffset = box.localToGlobal(Offset.zero);
        editor.editorSize = Offset(box.size.width, box.size.height);
        //
        // setState(() {});
        //
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final editor = EditorNotifier.of(context);
    final focusNode = FocusNode();

    return EditorNotifier(
      key: _viewerKey,
      model: editor,
      child: KeyboardListener(
        focusNode: focusNode,
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent) {
            EditorNotifier.of(context).updateKeyboardKey(event.logicalKey);
          } else if (event is KeyUpEvent) {
            EditorNotifier.of(context).updateKeyboardKey(null);
          }
        },
        child: Focus(
          autofocus: true,
          child: InteractiveViewer(
            constrained: false,
            panEnabled: true,
            transformationController: _controller,
            // boundaryMargin: const EdgeInsets.all(double.infinity),
            onInteractionEnd: (details) {},
            onInteractionUpdate: (details) {
              editor.editorRebuildStream.add(true);
            },
            minScale: 0.5,
            maxScale: 2.5,
            child: Listener(
              onPointerDown: (event) {
                editorPointerDown(editor, context, event);
              },
              child: Stack(
                children: [
                  Container(
                    color: Colors.transparent,
                    width: editor.idivisions * editor.iinterval,
                    height: editor.idivisions * editor.iinterval,
                    child: GridPaper(
                      color: Theme.of(context).colorScheme.primary,
                      divisions: editor.idivisions,
                      subdivisions: 1,
                      interval: editor.iinterval,
                    ),
                  ),

                  Positioned.fill(
                    child: LinkBuilder(
                      editor: editor,
                      animate: editor.rebuildLink,
                    ),
                  ),
                  ...editor.renderNodes(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void editorPointerDown(
  EditorChangeNotifier editor,
  BuildContext context,
  PointerDownEvent event,
) {
  if (event.kind == PointerDeviceKind.mouse &&
      event.buttons == kSecondaryMouseButton) {
    if (editor.activeLinkId != null) {
      final offset = event.position;

      final linkId = editor.activeLinkId;

      showMenu(
        context: context,
        menuPadding: EdgeInsets.zero,
        position: RelativeRect.fromLTRB(
          offset.dx,
          offset.dy,
          offset.dx + 200,
          offset.dy + 200,
        ),
        items: [
          PopupMenuItem(
            child: Text('Delete link'),
            onTap: () {
              editor.removeLinkById(linkId!);
            },
          ),
        ],
      );
    }
  }
}
