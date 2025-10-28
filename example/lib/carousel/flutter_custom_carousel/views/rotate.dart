import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel/flutter_custom_carousel.dart';

int getCircularDistance(int current, int target, int totalItems) {
  // Calculate clockwise distance
  int clockwise = (target - current + totalItems) % totalItems;

  // Calculate counter-clockwise distance
  int counterClockwise = (current - target + totalItems) % totalItems;

  // Return the minimum of the two distances
  return math.min(clockwise, counterClockwise);
}

enum CoverFlowStyle {
  none,
  scale,
  opacity,
  both;

  bool get isOpacity => this == CoverFlowStyle.opacity;
  bool get isScale => this == CoverFlowStyle.scale;
  bool get isBoth => this == CoverFlowStyle.both;
}

class RotateCoverFlowCarousel extends StatefulWidget {
  const RotateCoverFlowCarousel({
    super.key,
    this.style = CoverFlowStyle.both,
    required this.images,
    this.maxHeight = 150.0,
    this.minItemWidth = 40.0,
    this.maxItemWidth = 200.0,
    this.spacing = 20.0,
    this.yOffset = 40.0, // Control vertical offset
    this.zOffset = 100.0, // Control z-axis elevation
  });

  final CoverFlowStyle style;
  final List<String> images;
  final double maxHeight;
  final double minItemWidth;
  final double maxItemWidth;
  final double spacing;
  final double yOffset;
  final double zOffset;

  @override
  State<RotateCoverFlowCarousel> createState() =>
      _RotateCoverFlowCarouselState();
}

class _RotateCoverFlowCarouselState extends State<RotateCoverFlowCarousel> {
  late CustomCarouselScrollController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = CustomCarouselScrollController(initialItem: _selectedIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.maxHeight,
      child: CustomCarousel(
        itemCountBefore: 2,
        itemCountAfter: 2,
        scrollDirection: Axis.horizontal,
        loop: true,
        controller: _controller,
        alignment: Alignment.center,
        depthOrder: DepthOrder.selectedInFront,
        effectsBuilder: (index, ratio, child) {
          final go = 2 + 2 + 1;
          final itc = 2 / go;

          final distance = getCircularDistance(
            index,
            _selectedIndex,
            widget.images.length,
          );
          final adjustedDistance = distance * ratio.sign;

          final scale = widget.style.isScale || widget.style.isBoth
              ? 1.0 - (ratio.abs() * 0.15)
              : 1.0;

          final opacity = widget.style.isOpacity || widget.style.isBoth
              ? (1.0 - (ratio.abs() * 0.2)).clamp(0.0, 1.0)
              : 1.0;

          final rrr = ratio.abs();
          // final rrr = distance* itc ;

          // final itemWidth = widget.maxItemWidth * (distance / go);
          final itemWidth = (1 - rrr * 0) * widget.maxItemWidth;
          final remWidth = ratio.abs() * widget.maxItemWidth;

          // final tra =
          //     // -widget.maxItemWidth / 2 +
          //     // (_selectedIndex - index) *
          //     (ratio) * widget.maxItemWidth;

          // final xOffset = tra;
          // final xOffset = getCardPosition(distance);
          // final xOffset =
          //     // remWidth * adjustedDistance / 10 +
          //     (go / 2) * ratio * widget.maxItemWidth;
          final xOffset = .9 * (go / 2) * ratio * widget.maxItemWidth;
          // final xOffset = 1.8 * ratio * (itemWidth + widget.spacing * 2);

          // Reverse Z-offset calculation so center is closest (smallest negative Z)
          final zOffset = -widget.zOffset * ratio.abs() * .01;
          final yOffset = widget.yOffset * ratio.abs();

          // Create perspective effect
          final perspective = Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Add perspective
            ..translate(xOffset, yOffset, zOffset)
            ..rotateY(60 * ratio * math.pi / 180);

          return Transform(
            alignment: Alignment.center,
            // transform: getTransform(index, distance),
            transform: perspective,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.spacing),
              child: Transform.scale(
                scale: 1,
                // scale: scale,
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                    ),
                    child: Stack(
                      children: [
                        SizedBox(width: itemWidth, child: child),
                        Container(
                          decoration: BoxDecoration(color: Colors.black),
                          child: Column(
                            children: [
                              Text("i:${index}"),
                              Text("s:${_selectedIndex}"),
                              Text("d:${(adjustedDistance)}"),
                              Text("rr:${(distance * itc).toStringAsFixed(2)}"),
                              Text("r:${ratio.toStringAsFixed(2)}"),
                              Text("z:${xOffset.toStringAsFixed(2)}"),
                              Text("z:${zOffset.toStringAsFixed(2)}"),
                              Text("w:${itemWidth.toStringAsFixed(2)}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        onSelectedItemChanged: (value) => setState(() {
          _selectedIndex = value;
        }),
        children: List.generate(
          widget.images.length,
          (index) => _CoverFlowCard(
            imagePath: widget.images[index],
            isSelected: index == _selectedIndex,
            height: widget.maxHeight,
          ),
        ),
      ),
    );
  }
}

class _CoverFlowCard extends StatelessWidget {
  const _CoverFlowCard({
    required this.imagePath,
    required this.isSelected,
    required this.height,
  });

  final String imagePath;
  final bool isSelected;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(imagePath, height: height, fit: BoxFit.cover),
    );
  }
}

class RotateCoverFlowCarouselPage extends StatelessWidget {
  const RotateCoverFlowCarouselPage({super.key});

  @override
  Widget build(BuildContext context) {
    final valueNotifier = ValueNotifier<CoverFlowStyle>(CoverFlowStyle.both);

    return Scaffold(
      appBar: AppBar(title: const Text('Coverflow Carousel')),
      body: ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (context, style, _) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RotateCoverFlowCarousel(
                  style: style,
                  maxHeight: 180,
                  minItemWidth: 50,
                  maxItemWidth: 120,
                  spacing: 30,
                  yOffset: 40.0,
                  zOffset: 400.0,

                  images: const [
                    'assets/images/cover_slider/food-a-2.jpg',
                    'assets/images/cover_slider/food-a-1.jpg',
                    'assets/images/cover_slider/food-a-2.jpg',
                    'assets/images/cover_slider/food-a-3.jpg',
                    'assets/images/cover_slider/food-a-4.jpg',
                    'assets/images/cover_slider/food-a-5.jpg',
                    'assets/images/cover_slider/food-a-3.jpg',
                  ],
                ),
                const SizedBox(height: 20),
                SegmentedButton<CoverFlowStyle>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(
                      value: CoverFlowStyle.none,
                      label: Text('None'),
                    ),
                    ButtonSegment(
                      value: CoverFlowStyle.scale,
                      label: Text('Scale'),
                    ),
                    ButtonSegment(
                      value: CoverFlowStyle.opacity,
                      label: Text('Opacity'),
                    ),
                    ButtonSegment(
                      value: CoverFlowStyle.both,
                      label: Text('Both'),
                    ),
                  ],
                  selected: {style},
                  onSelectionChanged: (value) {
                    valueNotifier.value = value.last;
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
