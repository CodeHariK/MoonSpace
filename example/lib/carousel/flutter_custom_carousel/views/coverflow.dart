import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel/flutter_custom_carousel.dart';

int getCircularDistance(int current, int target, int totalItems) {
  // Calculate clockwise distance
  int clockwise = (target - current + totalItems) % totalItems;

  // Calculate counter-clockwise distance
  int counterClockwise = (current - target + totalItems) % totalItems;

  // Return the minimum of the two distances
  return Math.min(clockwise, counterClockwise);
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

class CoverFlowCarousel extends StatefulWidget {
  const CoverFlowCarousel({
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
  State<CoverFlowCarousel> createState() => _CoverFlowCarouselState();
}

class _CoverFlowCarouselState extends State<CoverFlowCarousel> {
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

          final itemWidth = (1 - rrr) * widget.maxItemWidth;

          final xOffset =
              (go / 2) * ratio * widget.maxItemWidth -
              adjustedDistance * distance * distance * 6;

          final zOffset = -widget.zOffset * ratio.abs() * .01;
          final yOffset = widget.yOffset * ratio.abs();

          // Create perspective effect
          final perspective = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..translate(xOffset, yOffset, zOffset);

          return Transform(
            alignment: Alignment.center,
            transform: perspective,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.spacing),
              child: Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        SizedBox(width: itemWidth, child: child),
                        Container(
                          decoration: BoxDecoration(color: Colors.black),
                          child: Column(
                            children: [
                              // Text("i:${index}"),
                              // Text("s:${_selectedIndex}"),
                              // Text("d:${(adjustedDistance)}"),
                              // Text("rr:${(distance * itc).toStringAsFixed(2)}"),
                              // Text("r:${ratio.toStringAsFixed(2)}"),
                              // Text("z:${xOffset.toStringAsFixed(2)}"),
                              // Text("z:${zOffset.toStringAsFixed(2)}"),
                              // Text("w:${itemWidth.toStringAsFixed(2)}"),
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

class CoverFlowCarouselPage extends StatelessWidget {
  const CoverFlowCarouselPage({super.key});

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
                CoverFlowCarousel(
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
