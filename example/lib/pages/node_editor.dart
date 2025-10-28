import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:example/pages/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';
import 'package:moonspace/node_editor/export.dart';
import 'package:moonspace/node_editor/links.dart';

// TODO: Drag and drop
// TODO: Performance Group Inherited widget, grouped node rebuild
// TODO: Trello list
// TODO: Excalidraw draw
// TODO: Layering

enum NodeTypes { recipe, slider, timer }

enum PortTypes { int, double, string, datetime, map }

final portBuilderRegistry = {
  //
  PortTypes.int.toString(): PortBuilderEntry<int>(
    deserialize: (p, value) => Port.merge(p, value as int),
    serialize: (value) => value,
  ),
  //
  PortTypes.double.toString(): PortBuilderEntry<double>(
    deserialize: (p, value) =>
        Port.merge(p, value != null ? value as double : null),
    serialize: (value) => value,
  ),
  //
  PortTypes.string.toString(): PortBuilderEntry<String>(
    deserialize: (p, value) =>
        Port.merge(p, value != null ? value as String : null),
    serialize: (value) => value,
  ),
  //
  PortTypes.datetime.toString(): PortBuilderEntry<DateTime>(
    deserialize: (p, value) =>
        Port.merge(p, value is String ? DateTime.tryParse(value) : null),
    serialize: (value) => value != null ? (value as DateTime).toString() : null,
  ),
  //
  PortTypes.map.toString(): PortBuilderEntry<Map<String, dynamic>>(
    deserialize: (p, value) =>
        Port.merge(p, value.runtimeType == String ? jsonDecode(value) : null),
    serialize: (value) => jsonEncode(value),
  ),
};

final nodeBuilderRegistry = {
  //
  NodeTypes.recipe.toString(): NodeBuilderEntry<Recipe>(
    builder: (context, node) => RecipeBox(node: node),
    deserialize: (n, value) => Node.merge(n, Recipe.deserialize(value)),
    serialize: (value) => (value is Recipe) ? value.serialize() : null,
  ),

  //
  NodeTypes.slider.toString(): NodeBuilderEntry<double>(
    builder: (context, node) => SliderBox(node: node),
    deserialize: (n, value) => Node.merge(n, value as double),
    serialize: (value) => value,
  ),

  //
  NodeTypes.timer.toString(): NodeBuilderEntry<double>(
    builder: (context, node) => TimerBox(node: node),
    deserialize: (n, value) => Node.merge(n, value as double),
    serialize: (value) => value,
  ),
};

class NodeEditorScaffold extends StatefulWidget {
  const NodeEditorScaffold({super.key});

  @override
  State<NodeEditorScaffold> createState() => _NodeEditorScaffoldState();
}

class _NodeEditorScaffoldState extends State<NodeEditorScaffold> {
  late final EditorChangeNotifier editor;

  @override
  void initState() {
    super.initState();

    editor =
        EditorChangeNotifier(
            ioffset: Offset(0, 0),
            izoom: 1,
            linkStyle: LinkStyle(
              linkColor: Colors.blue,
              linkType: LinkType.bezier,
              weight: 0,
              linkWidth: 4,
            ),
            idivisions: 8,
            iinterval: 160,
            nodeBuilderRegistry: nodeBuilderRegistry,
            portBuilderRegistry: portBuilderRegistry,
          )
          ..addNodes([
            TimerBox.newTimerNode('TimerNode1'),
            SliderBox.newSliderNode('SliderNode1', const Offset(20, 340)),
            SliderBox.newSliderNode('SliderNode2', const Offset(180, 340)),
            RecipeBox.newRecipeNode('RecipeNode1'),
          ])
          ..addLinksByPort([
            (
              nodeId1: "SliderNode1",
              index1: 0,
              nodeId2: "RecipeNode1",
              index2: 0,
              value: .5,
            ),
          ]);
  }

  @override
  Widget build(BuildContext context) {
    return EditorNotifier(
      model: editor,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: (context.mq.size.width - 500) / 2,
              top: (context.mq.size.height - 500) / 2,
              width: 500,
              height: 500,
              child: Container(
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                child: NodeEditor(),
              ),
            ),
            Align(alignment: Alignment.topLeft, child: EditorState()),
          ],
        ),
      ),
    );
  }
}

class Recipe {
  final int index;

  Recipe({required this.index});

  static Recipe deserialize(dynamic json) {
    return Recipe(index: json['index'] ?? 0);
  }

  Map<String, dynamic> serialize() {
    return {'index': index};
  }
}

class RecipeBox extends StatelessWidget {
  const RecipeBox({super.key, required this.node});

  final Node node;

  @override
  Widget build(BuildContext context) {
    if (node is! Node<Recipe>) return Text("Undefined");
    Recipe value = node.value;

    return RecipeCard(
      index: value.index % RecipesData.dessertMenu.length,
      delayMs: 0,
      downScroll: false,
    );
  }

  static Node<Recipe> newRecipeNode(String id) {
    return Node<Recipe>(
      id: id,
      type: NodeTypes.recipe.toString(),
      position: const Offset(220, 40),
      rotation: 0,
      size: const Offset(250, 250),
      value: Recipe(index: 2),
      ports: [
        Port<double>(
          type: PortTypes.double.toString(),
          input: true,
          offsetRatio: Offset(0, 0.3),
        ),
        Port<String>(
          type: PortTypes.string.toString(),
          input: false,
          offsetRatio: Offset(0, 0.7),
          value: "Hello",
        ),
      ],
    );
  }
}

class TimerBox extends StatefulWidget {
  const TimerBox({super.key, required this.node});

  final Node node;

  @override
  State<TimerBox> createState() => _TimerBoxState();

  static Node<double> newTimerNode(String id) {
    return Node<double>(
      id: id,
      type: NodeTypes.timer.toString(),
      position: const Offset(20, 100),
      rotation: 0,
      size: Offset(120, 120),
      value: .5,
      functions: {},
      ports: [
        Port<double>(
          type: PortTypes.double.toString(),
          input: false,
          offsetRatio: Offset(1, 0.3),
          value: 0.5,
        ),
        Port<String>(
          type: PortTypes.string.toString(),
          input: false,
          offsetRatio: Offset(1, 0.7),
          value: "Hello",
        ),
        Port<int>(
          type: PortTypes.int.toString(),
          input: false,
          offsetRatio: Offset(0, 0.3),
          value: 1,
        ),
        Port<DateTime>(
          type: PortTypes.datetime.toString(),
          input: false,
          offsetRatio: Offset(0, 0.7),
          value: DateTime.now(),
        ),
        Port<Map<String, dynamic>>(
          type: PortTypes.map.toString(),
          input: false,
          offsetRatio: Offset(0.3, 1),
          value: {"hello": "Hello"},
        ),
        // Port<Recipe>(
        //   input: false,
        //   offsetRatio: Offset(0.7, 1),
        //   value: Recipe(index: 1),
        // ),
        // Port<(double, double)>(
        //   input: false,
        //   offsetRatio: Offset(0.3, 0),
        //   value: (2, 3),
        // ),
        // Port<({String title, String subtitle})>(
        //   input: false,
        //   offsetRatio: Offset(0.7, 0),
        //   value: (title: "Hello", subtitle: "hello"),
        // ),
      ],
    );
  }
}

class _TimerBoxState extends State<TimerBox> {
  DateTime time = DateTime.now();

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (t) {
      if (mounted) {
        time = DateTime.now();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.purple),
      alignment: Alignment.center,
      child: Text(
        "${time.hour}:${time.minute}:${time.second}",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}

class SliderBox extends StatefulWidget {
  const SliderBox({super.key, required this.node});

  final Node node;

  @override
  State<SliderBox> createState() => _SliderBoxState();

  static Node<double> newSliderNode(String id, Offset position) {
    return Node<double>(
      id: id,
      type: NodeTypes.slider.toString(),
      position: position,
      rotation: 0,
      size: Offset(120, 120),
      value: .5,
      ports: [
        Port<double>(
          type: PortTypes.double.toString(),
          input: false,
          offsetRatio: Offset(1, 0.3),
        ),
        Port<String>(
          type: PortTypes.string.toString(),
          input: false,
          offsetRatio: Offset(1, 0.7),
        ),
      ],
    );
  }
}

class _SliderBoxState extends State<SliderBox> {
  int buildCount = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.node.value is! double) return Text("Undefined");

    final editor = EditorNotifier.of(context);

    buildCount++;

    return Card(
      elevation: 8,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(buildCount.toString()),

          Text(widget.node.value!.toStringAsFixed(2)),
          Slider(
            value: widget.node.value!,
            onChanged: (value) {
              final p1 = widget.node.ports.isNotEmpty
                  ? widget.node.ports.first
                  : null;

              setState(() {
                widget.node.value = value;
                if (p1 != null) {
                  editor.updatePortValue(p1, (value * 100).toInt() / 100);
                  final linkedPort = editor.getLinkedPort(p1);
                  if (linkedPort != null) {
                    editor.updateNodeRotation(
                      linkedPort.nodeId!,
                      (value * 6.28),
                    );
                  }
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

class EditorState extends StatefulWidget {
  const EditorState({super.key});

  @override
  State<EditorState> createState() => _EditorStateState();
}

class _EditorStateState extends State<EditorState> {
  bool showDrawer = false;

  String savedState = "";
  late final EditorChangeNotifier editor;

  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      editor = EditorNotifier.of(context);
      savedState = JsonEncoder.withIndent(" ").convert(editor.toMap());
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showDrawer)
          Container(
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              color: Theme.of(context).canvasColor,
            ),
            padding: EdgeInsets.all(4),
            child: ListView(
              children: [
                Text('Offset: ${editor.editorOffset}'),
                Text('Zoom: ${editor.izoom.toStringAsFixed(2)}'),
                Text(
                  'IOffset: ${editor.ioffset.dx.toStringAsFixed(1)},${editor.ioffset.dy.toStringAsFixed(1)}',
                ),
                Text('Nodes: ${editor.nodes.length}'),
                Column(
                  children: editor.links.values.map((v) => Text(v.id)).toList(),
                ),
                Text('Key: ${editor.activeKey}'),
                Text(
                  'Control: ${editor.activeKey == LogicalKeyboardKey.metaLeft}',
                ),
                FilledButton(
                  onPressed: () {
                    savedState = JsonEncoder.withIndent(
                      " ",
                    ).convert(editor.toMap());
                  },
                  child: Text("Serialize state"),
                ),
                if (savedState.isNotEmpty)
                  TextFormField(initialValue: savedState, maxLines: 12),
                FilledButton(
                  onPressed: () {
                    editor.clear();
                  },
                  child: Text("Clear state"),
                ),
                FilledButton(
                  onPressed: () {
                    final deserializedState = EditorChangeNotifier.fromMap(
                      jsonDecode(savedState),
                      nodeBuilderRegistry,
                      portBuilderRegistry,
                    );
                    editor.overwriteState(deserializedState);
                  },
                  child: Text("Reset state"),
                ),
                FilledButton(
                  onPressed: () {
                    editor.interactiveController.value = Matrix4.identity();
                  },
                  child: Text("Center"),
                ),

                ...editor.nodes.entries.map((node) {
                  return FilledButton(
                    onPressed: () {
                      editor.interactiveAnimateTo(node.value.center, context);
                    },
                    child: Text("Focus ${node.value.id}"),
                  );
                }),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: editor.nodeBuilderRegistry.entries
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            editor.addNodes(
                              List.generate(2000, (c) {
                                return SliderBox.newSliderNode(
                                  'NewSliderNode$c',
                                  Offset(
                                    Random().nextDouble() * 800,
                                    Random().nextDouble() * 800,
                                  ),
                                );
                              }),
                            );
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            margin: EdgeInsets.all(8),
                            color: Colors.red,
                            child: Text(e.key),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        IconButton.filled(
          onPressed: () {
            showDrawer = !showDrawer;
            setState(() {});
          },
          icon: Icon(Icons.keyboard_arrow_right),
        ),
        Text(editor.debug),
      ],
    );
  }
}
