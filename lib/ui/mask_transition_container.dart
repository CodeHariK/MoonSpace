import 'package:flutter/material.dart';
import 'package:moonspace/ui/widget_mask.dart';
import 'package:moonspace/ui/animated_sprite.dart';

class MaskTransitionContainer extends StatefulWidget {
  const MaskTransitionContainer({
    super.key,
    required this.child,
    required this.maskimage,
    required this.frameWidth,
    required this.frameHeight,
  });

  final Widget child;
  final ImageProvider maskimage;
  final int frameWidth;
  final int frameHeight;

  @override
  State<MaskTransitionContainer> createState() =>
      _MaskTransitionContainerState();
}

class _MaskTransitionContainerState extends State<MaskTransitionContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  );

  late final Animation<double> _animation = TweenSequence([
    TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 0.0), weight: 30),
    TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 34.0), weight: 70),
  ]).animate(_controller);

  Widget? _childForeground;
  late Widget? _childBackground = widget.child;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _childBackground = _childForeground;
          _childForeground = null;
        });
        _controller.reset();
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(MaskTransitionContainer oldWidget) {
    if (widget.child != oldWidget.child) {
      setState(() {
        _childForeground = widget.child;
      });
      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final appSize = constraints.biggest;
        final width = appSize.width;
        final height = appSize.height;

        List<Widget> children = [
          SizedBox(width: width, height: height, child: _childBackground),
        ];

        // If we swapped the child then add the foreground to the list of children when animating
        if (_childForeground != null) {
          children.add(
            // Draw the foreground masked over the background
            WidgetMask(
              maskChild: SizedBox(
                width: width,
                height: height,
                // Draw the transition animation as the mask
                child: AnimatedSprite(
                  image: widget.maskimage,
                  frameWidth: widget.frameWidth,
                  frameHeight: widget.frameHeight,
                  animation: _animation,
                ),
              ),
              child: SizedBox(
                width: width,
                height: height,
                child: _childForeground,
              ),
            ),
          );
        }

        return Positioned(
          left: 0,
          width: width,
          height: height,
          child: Stack(children: children),
        );
      },
    );
  }
}
