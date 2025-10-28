import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moonspace/node_editor/helper.dart';
import 'package:moonspace/node_editor/links.dart';
import 'package:moonspace/node_editor/node.dart';

class PortBuilderEntry<T> {
  final Widget Function(BuildContext context, Port port)? builder;
  final Port<T>? Function(Port port, dynamic json) deserialize;
  final dynamic Function(dynamic state) serialize;

  PortBuilderEntry({
    this.builder,
    required this.deserialize,
    required this.serialize,
  });
}

class Port<T> {
  int? index;
  String? nodeId;
  final String type;
  final bool input;
  final Offset offsetRatio;
  final bool quickUpdate;

  T? value;

  Port({
    this.index,
    this.nodeId,
    required this.type,
    this.input = false,
    required this.offsetRatio,
    this.value,
    this.quickUpdate = true,
  }) : assert(
         offsetRatio.dx >= 0.0 &&
             offsetRatio.dx <= 1.0 &&
             offsetRatio.dy >= 0.0 &&
             offsetRatio.dy <= 1.0,
       );

  String get id => '${nodeId}_$index';

  Map<String, dynamic> toMap(
    Map<String, PortBuilderEntry> portBuilderRegistry,
  ) {
    final entry = portBuilderRegistry[type];

    return {
      'index': index,
      'nodeId': nodeId,
      'type': type,
      'input': input,
      'offsetRatio': {'dx': offsetRatio.dx, 'dy': offsetRatio.dy},
      'value': entry?.serialize(value),
    };
  }

  static Port? fromMap(
    Map<String, dynamic> json,
    Map<String, PortBuilderEntry> portBuilderRegistry,
  ) {
    final type = json['type'];
    final entry = portBuilderRegistry[type];

    final dynamicPort = Port(
      index: json['index'],
      nodeId: json['nodeId'],
      type: json['type'],
      input: json['input'],
      offsetRatio: Offset(json['offsetRatio']['dx'], json['offsetRatio']['dy']),
      value: json['value'],
    );

    return entry?.deserialize(dynamicPort, json['value']);
  }

  factory Port.merge(Port port, T? value) {
    return Port<T>(
      nodeId: port.nodeId,
      index: port.index,
      type: port.type,
      offsetRatio: port.offsetRatio,
      input: port.input,
      value: value,
    );
  }

  Color get color => HSLColor.fromAHSL(
    1,
    (runtimeType.hashCode + 160) % 360,
    .5,
    .6,
  ).toColor();
}

class Link {
  final Port inputPort;
  final Port outputPort;

  String get id => inputPort.input
      ? "${inputPort.id}_${outputPort.id}"
      : "${outputPort.id}_${inputPort.id}";

  Link({required this.inputPort, required this.outputPort});

  Map<String, dynamic> toMap(Map<String, PortBuilderEntry> registry) => {
    'inputPort': inputPort.toMap(registry),
    'outputPort': outputPort.toMap(registry),
  };

  static Link? fromMap(
    Map<String, dynamic> json,
    Map<String, PortBuilderEntry> registry,
  ) {
    final input = Port.fromMap(json['inputPort'], registry);
    final output = Port.fromMap(json['outputPort'], registry);
    if (input == null || output == null) return null;
    return Link(inputPort: input, outputPort: output);
  }
}

class NodeBuilderEntry<T> {
  final Widget Function(BuildContext context, Node node) builder;
  final Node<T>? Function(Node node, dynamic state) deserialize;
  final dynamic Function(dynamic state) serialize;

  NodeBuilderEntry({
    required this.builder,
    required this.deserialize,
    required this.serialize,
  });
}

enum NodeFunction { move, rotate, resize, remove, ztop }

class Node<T> {
  final String id;
  final String type;
  Offset position;
  double rotation;
  Offset size;
  T? value;
  List<Port> ports;

  final Set<NodeFunction> functions;

  bool visible = false;
  bool active = false;

  Node({
    required this.id,
    required this.type,
    required this.position,
    required this.rotation,
    required this.size,
    this.value,
    required this.ports,
    this.functions = const {
      NodeFunction.move,
      NodeFunction.resize,
      NodeFunction.rotate,
      NodeFunction.remove,
      NodeFunction.ztop,
    },
  });

  Map<String, dynamic> toMap(
    Map<String, NodeBuilderEntry> nodeBuilderRegistry,
    Map<String, PortBuilderEntry> portBuilderRegistry,
  ) {
    final entry = nodeBuilderRegistry[type];

    return {
      'id': id,
      'type': entry != null ? type : null,
      'position': {'dx': position.dx, 'dy': position.dy},
      'rotation': rotation,
      'size': {'dx': size.dx, 'dy': size.dy},
      'value': entry?.serialize(value),
      'ports': ports.map((p) => p.toMap(portBuilderRegistry)).toList(),
    };
  }

  static Node? fromMap(
    Map<String, dynamic> json,
    Map<String, NodeBuilderEntry> nodeBuilderRegistry,
    Map<String, PortBuilderEntry> portBuilderRegistry,
  ) {
    final type = json['type'];
    final entry = nodeBuilderRegistry[type];

    final List<Port> ports = [];
    for (final p in (json['ports'] as List? ?? [])) {
      final port = Port.fromMap(p, portBuilderRegistry);
      if (port != null) {
        ports.add(port);
      }
    }

    final dynamicNode = Node(
      id: json['id'],
      type: entry != null ? type : '__error__',
      position: Offset(json['position']['dx'], json['position']['dy']),
      rotation: json['rotation'],
      size: Offset(json['size']['dx'], json['size']['dy']),
      ports: ports,
    );

    return entry?.deserialize(dynamicNode, json['value']);
  }

  factory Node.merge(Node n, T? value) {
    return Node<T>(
      id: n.id,
      type: n.type,
      position: n.position,
      rotation: n.rotation,
      size: n.size,
      ports: n.ports,
      value: value,
    );
  }

  Port? getPortById(int index) {
    if (index >= 0 && index < ports.length) {
      return ports[index];
    }
    return null;
  }

  Offset get center =>
      Offset(position.dx + size.dx / 2, position.dy + size.dy / 2);

  Offset ratioToLocal(Offset localRatio, double radius) {
    final dia = 2 * radius;
    final xpadr = dia / size.dx;
    final ypadr = dia / size.dy;

    // final leftside = localRatio.dx < xpadr;
    final rightside = (1 - localRatio.dx) < xpadr;

    final topside = localRatio.dy < ypadr;
    final bottomside = (1 - localRatio.dy) < ypadr;

    final push = Offset(
      (topside || bottomside) ? -radius : (rightside ? -2 * radius : 0),
      topside ? 0 : (bottomside ? -2 * radius : -radius),
    );

    return Offset(localRatio.dx * size.dx, localRatio.dy * size.dy) + push;
  }

  Offset ratioToGlobal(Offset localRatio, double radius) {
    final dia = 2 * radius;
    final xpadr = dia / size.dx;
    final ypadr = dia / size.dy;

    final leftside = localRatio.dx < xpadr;
    final rightside = (1 - localRatio.dx) < xpadr;

    final topside = localRatio.dy < ypadr;
    final bottomside = (1 - localRatio.dy) < ypadr;

    final push = Offset(
      leftside ? radius : (rightside ? -radius : 0),
      topside ? radius : (bottomside ? -radius : 0),
    );

    final unrotpos =
        position +
        Offset(localRatio.dx * size.dx, localRatio.dy * size.dy) +
        push;

    Offset rotpos = rotateAroundCenter(unrotpos, center, rotation);

    return rotpos;
  }
}

class CachedNode {
  final Widget widget;
  final Node node;
  int renderCount = 0;

  CachedNode(this.widget, this.node);
}

class EditorChangeNotifier extends ChangeNotifier {
  EditorChangeNotifier({
    required this.nodeBuilderRegistry,
    required this.portBuilderRegistry,

    //
    this.izoom = 1.0,
    this.ioffset = Offset.zero,
    this.iinterval = 500,
    this.idivisions = 4,

    this.editorOffset = Offset.zero,
    this.editorSize = const Offset(500, 500),

    //
    this.linkStyle = const LinkStyle(),
  });

  /// nodeid → Node
  final Map<String, Node> nodes = {};

  /// linkId → Link
  final Map<String, Link> links = {};

  final Map<String, NodeBuilderEntry> nodeBuilderRegistry;
  final Map<String, PortBuilderEntry> portBuilderRegistry;

  late final StreamController<Object?> editorRebuildStream;

  bool rebuildLink = false;
  void toggleLinkRebuild(bool rebuild) {
    rebuildLink = rebuild;
    notifyListeners();
  }

  Port? tempLinkStartPort;
  Offset? tempLinkEndPos;

  String? activeLinkId;

  LogicalKeyboardKey? activeKey;

  double izoom;
  Offset ioffset;
  double iinterval;
  int idivisions;

  double zoneRadius = 10;
  double scenePadding = 200;

  Offset editorOffset;
  Offset editorSize;

  final LinkStyle linkStyle;

  String debug = "";

  // Offset? debugEditGlobalPosition;
  // Offset? debugMousePosition;

  // void updateDebugEditGlobalPosition(Offset off) {
  //   debugEditGlobalPosition = off;
  // }

  // void updateDebugMousePosition(Offset off) {
  //   debugMousePosition = off;
  // }

  final TransformationController interactiveController =
      TransformationController();

  //----------------

  Map<String, dynamic> toMap() => {
    'izoom': izoom,
    'ioffset': {'dx': ioffset.dx, 'dy': ioffset.dy},
    'iinterval': iinterval,
    'idivisions': idivisions,

    //
    'nodes': nodes.map(
      (key, value) =>
          MapEntry(key, value.toMap(nodeBuilderRegistry, portBuilderRegistry)),
    ),
    'links': links.values
        .map((link) => link.toMap(portBuilderRegistry))
        .toList(),
  };

  factory EditorChangeNotifier.fromMap(
    Map<String, dynamic> json,
    Map<String, NodeBuilderEntry> nodeBuilderRegistry,
    Map<String, PortBuilderEntry> portBuilderRegistry,
  ) {
    final editor = EditorChangeNotifier(
      nodeBuilderRegistry: nodeBuilderRegistry,
      portBuilderRegistry: portBuilderRegistry,
    );

    editor.izoom = json['izoom'];
    editor.ioffset = Offset(json['ioffset']['dx'], json['ioffset']['dy']);
    editor.iinterval = json['iinterval'];
    editor.idivisions = json['idivisions'];

    List<MapEntry<String, Node<dynamic>>> parsedNodesNodes = [];
    (json['nodes'] as Map<String, dynamic>).forEach((key, nodedata) {
      final n = Node.fromMap(
        nodedata,
        nodeBuilderRegistry,
        portBuilderRegistry,
      );
      if (n != null) {
        parsedNodesNodes.add(MapEntry(key, n));
      }
    });
    editor.nodes.addEntries(parsedNodesNodes);

    final List<Link> parsedLinks = [];
    for (final linkJson in (json['links'] as List? ?? [])) {
      final link = Link.fromMap(linkJson, portBuilderRegistry);
      if (link != null) {
        parsedLinks.add(link);
      }
    }
    editor.addLinks(parsedLinks);

    return editor;
  }

  void overwriteState(EditorChangeNotifier other) {
    // izoom = other.izoom;
    // ioffset = other.ioffset;
    // iinterval = other.iinterval;
    // idivisions = other.idivisions;
    nodes
      ..clear()
      ..addAll(other.nodes);
    links
      ..clear()
      ..addAll(other.links);
    notifyListeners();
  }

  void mergeState(EditorChangeNotifier other) {
    nodes.addAll(other.nodes);
    links.addAll(other.links);
    notifyListeners();
  }

  //----------------

  Node? getNodeById(String id) => nodes[id];

  void addNodes(List<Node> nodelist) {
    for (var node in nodelist) {
      for (int i = 0; i < node.ports.length; i++) {
        node.ports[i].index = i;
        node.ports[i].nodeId = node.id;
      }
      nodes[node.id] = node;
    }

    notifyListeners();
  }

  void removeNodeById(String nodeId) {
    nodes.remove(nodeId);

    final affectedLinkIds = links.entries
        .where(
          (linkentry) =>
              linkentry.value.inputPort.nodeId == nodeId ||
              linkentry.value.outputPort.nodeId == nodeId,
        )
        .map((entry) => entry.key)
        .toList();

    for (final id in affectedLinkIds) {
      removeLinkById(id);
    }

    notifyListeners();
  }

  void clear() {
    nodes.clear();
    links.clear();
    notifyListeners();
  }

  //----------------

  Link? getLinkById(String id) => links[id];

  List<Link> getLinksForPort(Port port) {
    return links.values.where((link) {
      return link.inputPort.id == port.id || link.outputPort.id == port.id;
    }).toList();
  }

  Port? getLinkedPort(Port port) {
    for (final link in getLinksForPort(port)) {
      if (link.inputPort.id == port.id) return link.outputPort;
      if (link.outputPort.id == port.id) return link.inputPort;
    }
    return null;
  }

  void addLinks(List<Link> linklist) {
    for (var link in linklist) {
      if (link.inputPort.nodeId == link.outputPort.nodeId ||
          link.inputPort.runtimeType != link.outputPort.runtimeType) {
        continue;
      }

      // Remove existing link to this input port if it exists
      for (final existing in getLinksForPort(link.inputPort)) {
        links.remove(existing.id);
      }

      links[link.id] = link;
    }
  }

  void addLinksByPort(
    List<
      ({String nodeId1, int index1, String nodeId2, int index2, dynamic value})
    >
    linklist,
  ) {
    List<Link> l = [];
    for (var e in linklist) {
      final n1 = getNodeById(e.nodeId1);
      final n2 = getNodeById(e.nodeId2);
      final p1 = n1?.getPortById(e.index1);
      final p2 = n2?.getPortById(e.index2);

      p1?.value = e.value;
      p2?.value = e.value;

      if (p1 != null && p2 != null) {
        l.add(
          Link(inputPort: p1.input ? p1 : p2, outputPort: p1.input ? p2 : p1),
        );
      }
    }
    addLinks(l);
  }

  // void updateLinkValue(String linkId, dynamic value) {
  //   final link = links[linkId];
  //   if (link != null) {
  //     link.inputPort.value = value;
  //     link.outputPort.value = value;
  //     // print("updateLinkValue");
  //     // notifyListeners();
  //   }
  // }

  void updatePortValue(Port port, dynamic value) {
    port.value = value;
    for (final link in getLinksForPort(port)) {
      link.inputPort.value = value;
      link.outputPort.value = value;
    }
    if (port.quickUpdate) {
      notifyListeners();
    } else {
      editorRebuildStream.add(true);
    }
  }

  void notifyEditor() {
    notifyListeners();
  }

  void removeLinkById(String id) {
    links.remove(id);
  }

  //----------------

  void updateNodePosition(String id, Offset pos) {
    if (nodes.containsKey(id)) {
      nodes[id]!.position = pos;
    }
  }

  void updateNodeRotation(String id, double rot) {
    nodes[id]?.rotation = rot;
  }

  void updateNodeSize(String id, Offset size) {
    if (nodes.containsKey(id)) {
      nodes[id]!.size = size;
    }
  }

  //----------------

  void updateInteractiveZoom(double z) {
    izoom = z;
  }

  void updateInteractiveOffset(Offset off) {
    ioffset = off;
  }

  void updateKeyboardKey(LogicalKeyboardKey? key) {
    activeKey = key;
  }

  void removeTempLink() {
    tempLinkStartPort = null;
    tempLinkEndPos = null;
    rebuildLink = false;
    notifyListeners();
  }

  void interactiveAnimateTo(Offset sceneTarget, BuildContext context) {
    final zoom = interactiveController.value.getMaxScaleOnAxis();

    final size = MediaQuery.of(context).size;
    final dx = size.width / 2 - sceneTarget.dx * zoom;
    final dy = size.height / 2 - sceneTarget.dy * zoom;

    interactiveController.value = Matrix4.identity()
      ..translate(dx, dy)
      ..scale(zoom);
  }

  //----------------

  ({Node node, Offset offset}) getPortOffset(Port port) {
    final node = getNodeById(port.nodeId!)!;
    return (
      node: node,
      offset: node.ratioToGlobal(port.offsetRatio, zoneRadius),
    );
  }

  Offset localToCanvasOffset(Offset localPos, BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final global = renderBox.localToGlobal(localPos - editorOffset / izoom);
    final matrixInverse = interactiveController.value.clone()..invert();
    return MatrixUtils.transformPoint(matrixInverse, global);
  }

  Offset globalToCanvas(Offset global) {
    return (global - editorOffset - ioffset) / izoom;
  }

  bool checkIfNodeVisible(Node node) {
    // Viewport in scene space

    final sceneTopLeft = (Offset.zero - ioffset) / izoom;
    final sceneBottomRight = (editorSize - ioffset) / izoom;

    // Expand viewport with padding (converted to scene scale)
    final viewport = Rect.fromPoints(
      sceneTopLeft,
      sceneBottomRight,
    ).inflate(scenePadding);

    final nodeRect = Rect.fromLTWH(
      node.position.dx,
      node.position.dy,
      node.size.dx,
      node.size.dy,
    );

    return nodeRect.overlaps(viewport);
  }

  List<Node> visibleNodes = [];
  List<Widget> visibleWidgets = [];
  final LinkedHashMap<String, CachedNode> _visibleNodeCache = LinkedHashMap();
  int _cacheClearCount = 0;
  final int _cacheClearThreshold = 10;
  int _rebuildCount = 0;
  final int _rebuildResetThreshold = 100;
  final int _maxCacheItemCount = 200;

  List<Widget> renderNodes() {
    //
    visibleNodes.clear();
    visibleWidgets.clear();

    int cachedCount = 0;

    for (final entry in nodes.entries) {
      final node = entry.value;
      final id = node.id;

      if (checkIfNodeVisible(node)) {
        final cached = _visibleNodeCache[id];

        visibleNodes.add(node);
        node.visible = true;

        cachedCount++;

        if (cached != null) {
          cached.renderCount += 1;
          visibleWidgets.add(cached.widget);
        } else {
          final widget = CustomNode(
            key: ValueKey(id),
            node: node,
            portBuilderRegistry: portBuilderRegistry,
            nodeBuilderRegistry: nodeBuilderRegistry,
          );

          _visibleNodeCache[id] = CachedNode(widget, node)..renderCount = 1;
          visibleWidgets.add(widget);
        }
      } else {
        node.visible = false;
        node.active = false;
      }
    }

    int deleted = 0;

    _cacheClearCount++;
    if (_visibleNodeCache.length > _maxCacheItemCount &&
        _cacheClearCount >= _cacheClearThreshold) {
      _cacheClearCount = 0;
      final targetSize = (_maxCacheItemCount * 0.7).floor();

      // Collect non-visible entries
      final nonVisible = _visibleNodeCache.entries
          .where((e) => !e.value.node.visible)
          .toList();

      // Sort by least used first
      nonVisible.sort(
        (a, b) => a.value.renderCount.compareTo(b.value.renderCount),
      );

      for (final entry in nonVisible) {
        if (_visibleNodeCache.length <= targetSize) break;
        _visibleNodeCache.remove(entry.key);
        deleted++;
      }
    }

    _rebuildCount++;
    if (_rebuildCount >= _rebuildResetThreshold) {
      _rebuildCount = 0;
      for (final entry in _visibleNodeCache.entries) {
        entry.value.renderCount = 0;
      }
    }

    debug =
        "Visible: ($cachedCount ${visibleWidgets.length - cachedCount})/${nodes.length}, deleted: $deleted, active: ${visibleNodes.where((n) => n.active).length}";

    return visibleWidgets;
  }

  bool isInRegion(Offset center, Offset globalPos) {
    return (globalPos - center).distance < zoneRadius;
  }

  bool isInPort(Node node, Port port, Offset globalPos) {
    return isInRegion(
      node.ratioToGlobal(port.offsetRatio, zoneRadius),
      globalPos,
    );
  }

  Offset topright(Node node) =>
      node.ratioToGlobal(offsetTopRightRatio, zoneRadius);
  Offset topcenter(Node node) =>
      node.ratioToGlobal(offsetTopCenterRatio, zoneRadius);
  Offset bottomright(Node node) =>
      node.ratioToGlobal(offsetBottomRightRatio, zoneRadius);
  Offset bottomleft(Node node) =>
      node.ratioToGlobal(offsetBottomLeftRatio, zoneRadius);
}

class EditorNotifier extends InheritedNotifier<EditorChangeNotifier> {
  const EditorNotifier({
    super.key,
    required EditorChangeNotifier model,
    required super.child,
  }) : super(notifier: model);

  static EditorChangeNotifier of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<EditorNotifier>()!.notifier!;
}
