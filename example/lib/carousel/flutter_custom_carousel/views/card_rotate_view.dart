import 'package:example/carousel/flutter_custom_carousel/views/demo_chrome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel/flutter_custom_carousel.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CardRotateView extends StatelessWidget {
  const CardRotateView({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoChrome(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Our Menu', title: true),
                _buildLabel('Starters'),
                _buildCarouselRow('a', 10),
                _buildLabel('Popular Entrées'),
                _buildCarouselRow('b', 10),
                _buildLabel('Something Sweet'),
                _buildCarouselRow('c', 10, height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselRow(String category, int count, {double? height = 100}) {
    // Build a list of widgets for the carousel items:
    List<Widget> items = List.generate(count, (i) => _Card(category, i + 1));

    double rotationMultiplier = 0.2; // radians
    double scaleMin = 0.85; // minimum scale
    double opacityMin = 0.5; // minimum opacity

    Widget carousel = CustomCarousel(
      itemCountBefore: 3,
      itemCountAfter: 3,
      alignment: Alignment.center,
      scrollDirection: Axis.horizontal,
      loop: true,
      depthOrder: DepthOrder.selectedInFront,
      tapToSelect: false,
      effectsBuilder: (_, ratio, child) {
        double angle = ratio * rotationMultiplier;
        double distance = ratio.abs();

        double scale = (1 - distance).clamp(scaleMin, 1.0);
        double opacity = (1 - distance).clamp(opacityMin, 1.0);

        // Vertical offset increases with distance
        double yOffset = distance * 20; // Adjust 20 for how low it goes

        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(ratio * 170 * 2, yOffset),
            child: Transform.rotate(
              angle: angle,
              child: Transform.scale(scale: scale, child: child),
            ),
          ),
        );
      },
      // Pass in the list of widgets we created above:
      children: items,
    );

    return SizedBox(height: height, child: carousel);
  }

  Widget _buildLabel(String label, {bool title = false}) {
    return Padding(
      padding: EdgeInsets.only(top: title ? 56 : 24, bottom: title ? 0 : 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: title ? 40 : 18,
          fontWeight: FontWeight.bold,
          color: title ? Colors.deepOrange : Colors.grey[800],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card(this.category, this.index, {Key? key}) : super(key: key);

  final String category;
  final int index;

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      width: 160,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/cover_slider/food-$category-${(index % 6) + 1}.jpg',
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return GestureDetector(
      onTap: () => _showDetails(context, category, index),
      child: Hero(tag: 'food-$category-$index', child: content),
    );
  }

  void _showDetails(BuildContext context, String category, int index) {
    PageRouteBuilder route = PageRouteBuilder(
      pageBuilder: (_, __, ___) => _DetailView(category, index),
      transitionDuration: 300.ms,
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
    );
    Navigator.push(context, route);
  }
}

class _DetailView extends StatelessWidget {
  const _DetailView(this.category, this.index, {Key? key}) : super(key: key);

  final String category;
  final int index;

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/cover_slider/food-$category-${(index % 6) + 1}.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: AspectRatio(
          aspectRatio: 1,
          child: Hero(tag: 'food-$category-$index', child: content),
        ),
      ),
    );
  }
}
