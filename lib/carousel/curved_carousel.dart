import 'package:flutter/widgets.dart';
import 'package:flutter_custom_carousel/flutter_custom_carousel.dart';

class CurvedCarousel extends StatelessWidget {
  const CurvedCarousel({
    super.key,
    required this.count,
    this.height = 100,
    this.width = 170,
    this.controller,
    this.itemCountBefore = 2,
    this.itemCountAfter = 2,
    this.rotationMultiplier = 0.2,
    this.xMultiplier = 3,
    this.yMultiplier = 50,
    this.scaleMin = 0.9,
    this.opacityMin = 0.5,
    this.alignment = Alignment.center,
    this.staticBuilder,
    this.animatedBuilder,
    this.onSelectedItemChanged,
    this.onSettledItemChanged,
  });

  final int count;
  final CustomCarouselScrollController? controller;
  final double height;
  final double width;
  final int itemCountBefore;
  final int itemCountAfter;
  final double rotationMultiplier;
  final double scaleMin;
  final double opacityMin;
  final double xMultiplier;
  final double yMultiplier;
  final Alignment? alignment;
  final Widget Function(int index)? staticBuilder;
  final Widget Function(int index, double ratio)? animatedBuilder;
  final void Function(int index)? onSelectedItemChanged;
  final void Function(int index)? onSettledItemChanged;

  @override
  Widget build(BuildContext context) {
    assert(!(staticBuilder == null && animatedBuilder == null));

    List<Widget> items = List.generate(
      count,
      (i) => staticBuilder?.call(i) ?? const SizedBox(),
    );

    Widget carousel = CustomCarousel(
      itemCountBefore: itemCountBefore,
      itemCountAfter: itemCountAfter,
      controller: controller,
      alignment: alignment,
      scrollDirection: Axis.horizontal,
      loop: true,
      depthOrder: DepthOrder.selectedInFront,
      tapToSelect: false,
      onSelectedItemChanged: (index) {
        onSelectedItemChanged?.call(index);
      },
      onSettledItemChanged: (index) {
        if (index != null) {
          onSettledItemChanged?.call(index);
        }
      },
      effectsBuilder: (index, ratio, child) {
        double angle = ratio * rotationMultiplier;
        double distance = ratio.abs();

        double scale = (1 - distance).clamp(scaleMin, 1.0);
        double opacity = (1 - distance).clamp(opacityMin, 1.0);

        return Transform.translate(
          offset: Offset(ratio * width * xMultiplier, distance * yMultiplier),
          child: Transform.rotate(
            angle: angle,
            child: Transform.scale(
              scale: scale,
              child: Opacity(
                opacity: opacity,
                child: animatedBuilder?.call(index, ratio) ?? child,
              ),
            ),
          ),
        );
      },
      children: items,
    );

    return SizedBox(height: height, child: carousel);
  }
}
