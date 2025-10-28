import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

//////|___________|//////
//////|           |//////
//////|  Overlay  |//////
//////|           |//////
//////|___________|//////

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;

  const LoadingScreenController({required this.close, required this.update});
}

class LoadingScreen {
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  LoadingScreen._sharedInstance();
  factory LoadingScreen() => _shared;

  LoadingScreenController? controller;

  LoadingScreenController? show({
    required BuildContext context,
    required String text,
    Widget? action,
    bool hideable = true,
  }) {
    if (controller?.update(text) ?? false) {
    } else {
      controller = _showOverlay(
        context: context,
        text: text,
        action: action,
        hideable: hideable,
      );
    }
    return controller;
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  LoadingScreenController _showOverlay({
    required BuildContext context,
    required String text,
    Widget? action,
    bool hideable = true,
  }) {
    final infoText = StreamController<String>();
    infoText.add(text);

    final state = Overlay.of(context);
    // final renderBox = context.findRenderObject() as RenderBox;
    // final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return LoadingBox(
          textStream: infoText,
          action: action,
          hideable: hideable,
        );
      },
    );

    state.insert(overlay);

    return LoadingScreenController(
      close: () {
        infoText.close();
        overlay.remove();
        overlay.dispose();
        return true;
      },
      update: (text) {
        infoText.add(text);
        return true;
      },
    );
  }
}

class LoadingBox extends StatelessWidget {
  const LoadingBox({
    super.key,
    required this.textStream,
    this.action,
    this.hideable = true,
  });

  final StreamController<String> textStream;
  final Widget? action;
  final bool hideable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (hideable) {
          LoadingScreen().hide();
        }
      },
      child: Animate(
        effects: const [
          FadeEffect(
            begin: 0,
            end: 1,
            duration: Duration(milliseconds: 300),
          ),
        ],
        child: Material(
          color: Colors.blue.withAlpha(40),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 400,
                maxHeight: 300,
                minWidth: 300,
                // maxHeight: size.height * 0.8,
                // minWidth: min(size.width * 0.5, 400),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: StreamBuilder(
                          stream: textStream.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Stack(
                                children: [
                                  Center(
                                    child: SizedBox(
                                      width: 200,
                                      height: 200,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 10,
                                        value: double.tryParse(
                                                snapshot.data ?? '0')
                                            ?.clamp(0, 1),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      snapshot.data as String,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      if (action != null) action!
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedOverlay extends StatefulWidget {
  const AnimatedOverlay({
    super.key,
    required this.builder,
    this.duration,
    required this.scafSize,
    required this.offset,
    this.alignment = Alignment.bottomCenter,
  });

  final Widget Function(bool hide, Size scafSize, Offset offset) builder;
  final Duration? duration;
  final Offset offset;
  final Size scafSize;
  final AlignmentGeometry alignment;

  static LoadingScreenController? controller;

  static void show({
    required BuildContext context,
    required Widget Function(bool hide, Size scafSize, Offset offset) builder,
    Duration? duration,
    AlignmentGeometry alignment = Alignment.bottomCenter,
  }) {
    hide();
    final state = Overlay.of(context);

    final renderBox = context.findRenderObject() as RenderBox;
    final offsetSize = renderBox.size;
    final Offset offset =
        renderBox.localToGlobal(Offset(offsetSize.width / 2, 0));
    final scafSize =
        (Scaffold.of(context).context.findRenderObject() as RenderBox).size;

    final overlay = OverlayEntry(
      builder: (context) {
        return AnimatedOverlay(
          duration: duration,
          builder: builder,
          scafSize: scafSize,
          offset: offset,
          alignment: alignment,
        );
      },
    );

    state.insert(overlay);

    controller = LoadingScreenController(
      close: () {
        overlay.remove();
        overlay.dispose();
        return true;
      },
      update: (text) {
        return true;
      },
    );
  }

  static void hide() {
    controller?.close();
    controller = null;
  }

  @override
  State<AnimatedOverlay> createState() => _AnimatedOverlayState();
}

class _AnimatedOverlayState extends State<AnimatedOverlay> {
  bool hide = false;

  late final Timer timer;

  @override
  void initState() {
    if (widget.duration != null) {
      timer = Timer(widget.duration!, () {
        if (mounted) {
          hide = true;
          setState(() {});
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () => setState(() => hide = true),
      onVerticalDragStart: (details) {
        if (mounted) {
          setState(() => hide = true);
        }
      },
      onHorizontalDragStart: (details) {
        if (mounted) {
          setState(() => hide = true);
        }
      },
      child: SafeArea(
        top: false,
        child: Material(
          type: (widget.duration != null)
              ? MaterialType.transparency
              : MaterialType.canvas,
          color: Colors.transparent,
          child: Stack(
            alignment: widget.alignment,
            children: [
              widget.builder(hide, widget.scafSize, widget.offset),
            ],
          ),
        ),
      ),
    );
  }
}
