import 'dart:math';

import 'package:flutter/material.dart';

class CircularCarousel extends StatefulWidget {
  final double? radius;
  final double radiusMultiplier;

  const CircularCarousel({super.key, this.radius, this.radiusMultiplier = 0.4});

  @override
  State<CircularCarousel> createState() => _CircularCarouselState();
}

class _CircularCarouselState extends State<CircularCarousel> {
  late PageController _controller;
  double _currentPage = 3.0; // Add initial page value

  final itemsCount = 11;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: 1 / itemsCount,
      initialPage: 3,
    );
    // Add listener to update currentPage
    _controller.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onPageChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    setState(() {
      _currentPage = _controller.page ?? _currentPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    const int allItemsCount = 30;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;
        final double radius =
            widget.radius ?? (width * widget.radiusMultiplier);

        // Center based on parent constraints
        final double centerX = width / 2;
        final double centerY = height / 2;

        return Stack(
          fit: StackFit.expand,
          children: [
            ...List.generate(allItemsCount, (index) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final half = (itemsCount / 2).toInt();
                  // Use _currentPage instead of accessing controller.page directly
                  double ratio = (index - _currentPage) / half;
                  ratio = ratio.clamp(-1.0, 1.0);

                  // Calculate circular position
                  double angle = -ratio * pi - pi / 2; // Full circle: -π to π
                  double x = centerX + (radius * cos(angle));
                  double y = centerY + (radius * sin(angle));

                  // Scale based on position (largest at center)
                  double scale = cos(ratio * pi / 2).abs();
                  scale = 1; //scale.clamp(0.3, 1.0);

                  if (index <= _currentPage - half ||
                      index >= _currentPage + half) {
                    return SizedBox();
                  }

                  return Positioned(
                    left: x - 50, // + Random().nextInt(50),
                    top: y - 50, // + Random().nextInt(50),
                    child: Transform(
                      transform: Matrix4.identity()..scale(scale),
                      child: Opacity(
                        opacity: 1,
                        child: Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors
                                .primaries[index % Colors.primaries.length]
                                .withAlpha(50),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('i:$index'),
                              Text(
                                '${(_currentPage - half).toStringAsFixed(2)}  ${(_currentPage + half).toStringAsFixed(2)}',
                              ),
                              // Text('x:${x.toStringAsFixed(2)}'),
                              // Text('y:${y.toStringAsFixed(2)}'),
                              Text('r:${ratio.toStringAsFixed(2)}'),
                              // Text(
                              //   'a:${(angle * math.radians2Degrees).toStringAsFixed(2)}',
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),

            // Debug center point
            Positioned(
              left: centerX - 5,
              top: centerY - 5,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            PageView.builder(
              controller: _controller,
              itemCount: allItemsCount,
              itemBuilder: (context, index) {
                return SizedBox();
              },
            ),
          ],
        );
      },
    );
  }
}
