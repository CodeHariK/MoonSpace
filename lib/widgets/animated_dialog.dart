import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonspace/widgets/animated_overlay.dart';

class AnimatedDialogBox extends StatelessWidget {
  const AnimatedDialogBox({
    super.key,
    this.hide = true,
    required this.boxSize,
    this.scafSize = Size.zero,
    this.offset = Offset.zero,
    required this.child,
  });

  final bool hide;
  final Size boxSize;
  final Offset offset;
  final Size scafSize;
  final Widget child;

  AnimatedDialogBox copyWith({
    bool? hide,
    Widget? child,
    Size? boxSize,
    Offset? offset,
    Size? scafSize,
  }) {
    return AnimatedDialogBox(
      hide: hide ?? this.hide,
      boxSize: boxSize ?? this.boxSize,
      offset: offset ?? this.offset,
      scafSize: scafSize ?? this.scafSize,
      child: child ?? this.child,
    );
  }

  void show(
    BuildContext context, {
    Duration? duration,
    AlignmentGeometry alignment = Alignment.bottomCenter,
  }) {
    AnimatedOverlay.show(
      context: context,
      alignment: alignment,
      duration: duration,
      builder: (hide, scafSize, offset) {
        return copyWith(
          hide: hide,
          scafSize: scafSize,
          offset: offset,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: hide ? 0.9 : 0.0, end: hide ? 0.0 : 0.9),
      curve: Curves.easeInOut,
      onEnd: () {
        if (hide) {
          AnimatedOverlay.hide();
        }
      },
      builder: (context, value, child) {
        final x = offset.dx - (value * (boxSize.width / 2));
        final y = offset.dy - (value * boxSize.height) - 10;
        return Positioned(
          left: clampDouble(x, 10, scafSize.width - value * boxSize.width - 10),
          top: clampDouble(
              y, 100, scafSize.height - value * boxSize.height - 100),
          child: Semantics(
            label: 'Dialog box',
            child: Container(
              width: value * boxSize.width,
              clipBehavior: Clip.antiAlias,
              height: value * boxSize.height,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular((1 - value) * 200),
              ),
              child: Opacity(
                opacity: value,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    onHorizontalDragStart: (details) {},
                    onVerticalDragStart: (details) {},
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}
