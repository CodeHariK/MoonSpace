import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({super.key, required this.shimmer, required this.child});

  final bool shimmer;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return shimmer
        ? child
              .animate(
                onPlay: (controller) {
                  controller.repeat();
                },
              )
              .shimmer(
                delay: 1500.ms,
                duration: 1500.ms,
                curve: Curves.decelerate,
                angle: 1,
              )
        : child;
  }
}

class SwipeButton extends StatefulWidget {
  const SwipeButton({
    super.key,
    required this.child,
    required this.dragChild,
    this.dragOnly = true,
    this.leftChild,
    this.rightChild,
    this.decoration,
  });

  final Widget child;
  final BoxDecoration? decoration;
  final Widget? leftChild;
  final Widget? rightChild;
  final Widget dragChild;
  final bool dragOnly;

  @override
  State<SwipeButton> createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton>
    with SingleTickerProviderStateMixin {
  double position = 0;
  bool dragging = false;
  double targetPosition = 0;
  double previousPosition = 0;
  Offset? _dragStartOffset;
  double _dragStartPosition = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final radius = height * 0.8;

        return GestureDetector(
          onHorizontalDragStart: (details) {
            final circleCenterX = position + radius / 2;
            _dragStartOffset = details.localPosition;
            _dragStartPosition = position;
            dragging = true;
            previousPosition = position;
            setState(() {});
          },
          onHorizontalDragEnd: (details) {
            dragging = false;
            _dragStartOffset = null;
            targetPosition = position < width / 2 ? 0 : width - radius;
            setState(() {});
          },
          onHorizontalDragUpdate: (details) {
            if (_dragStartOffset == null) return;

            final delta = details.localPosition.dx - _dragStartOffset!.dx;
            final double newPosition = (_dragStartPosition + delta).clamp(
              0,
              width - radius,
            );

            if (position != newPosition) {
              position = newPosition;
              setState(() {});
            }
          },
          onTapDown: widget.dragOnly
              ? null
              : (details) {
                  dragging = false;
                  previousPosition = position;
                  // Determine target based on tap location instead of current position
                  targetPosition = details.localPosition.dx > width / 2
                      ? width - radius
                      : 0;
                  setState(() {});
                },
          behavior: HitTestBehavior.translucent,
          child: Container(
            decoration: widget.decoration,
            child: Stack(
              alignment: Alignment.center,
              children: [
                widget.child,

                if (widget.leftChild != null)
                  Positioned(
                    left: 0,
                    child: ShimmerBox(
                      shimmer: position > width / 2,
                      child: widget.leftChild!,
                    ),
                  ),

                if (widget.rightChild != null)
                  Positioned(
                    right: 0,
                    child: ShimmerBox(
                      shimmer: position > width / 2,
                      child: widget.rightChild!,
                    ),
                  ),

                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween<double>(
                    begin: previousPosition,
                    end: dragging ? position : targetPosition,
                  ),
                  onEnd: () {
                    position = targetPosition;
                    previousPosition = position;
                  },
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Positioned(
                      left: value,
                      top: (height - radius) / 2,
                      child: Transform.rotate(
                        angle: 2 * pi * (value / (width - radius)),
                        child: SizedBox(
                          width: radius,
                          height: radius,
                          child: Center(child: widget.dragChild),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
