import 'package:example/carousel/flutter_custom_carousel/views/demo_chrome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel/flutter_custom_carousel.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CircleSingle extends StatefulWidget {
  const CircleSingle({super.key});

  @override
  State<CircleSingle> createState() => _CircleSingleState();
}

class _CircleSingleState extends State<CircleSingle> {
  List<int> _cardIndexes = List.generate(14, (i) => i);
  int _selectedIndex = 0;
  late CustomCarouselScrollController _controller;

  @override
  void initState() {
    _controller = CustomCarouselScrollController();
    Future.delayed(300.ms, _shuffleDeck); // small delay for nav to settle
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Expanded(child: _buildCarousel());
    return DemoChrome(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/card_deck/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: _buildCarousel()),
              Padding(
                padding: const EdgeInsets.only(bottom: 32, top: 16),
                child: _buildNextBtn(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    List<Widget> items = List.generate(
      _cardIndexes.length,
      (i) => _Card(_cardIndexes[i]),
    );

    // Note: we could wrap the carousel in IgnorePointer to prevent user interaction.
    // but it's kinda fun to play with in the demo, so we'll leave it enabled.

    double rotationMultiplier = 0.2; // radians
    double scaleMin = 0.9; // minimum scale
    double opacityMin = 0.5; // minimum opacity

    return CustomCarousel(
      itemCountBefore: 2,
      itemCountAfter: 2,
      physics: const CustomCarouselScrollPhysics(sticky: true),
      alignment: Alignment.center,
      scrollDirection: Axis.horizontal,
      loop: true,
      depthOrder: DepthOrder.selectedInFront,
      tapToSelect: false,
      controller: _controller,
      effectsBuilder: (_, ratio, child) {
        double angle = ratio * rotationMultiplier;
        double distance = 2.5 * ratio.abs();

        double scale = (1 - distance).clamp(scaleMin, 1.0);
        double opacity = (1 - distance).clamp(0, 1.0);

        // Vertical offset increases with distance
        double yOffset = distance * 50; // Adjust 20 for how low it goes

        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(ratio * 170 * 3, yOffset),
            child: Transform.rotate(
              angle: angle,
              child: Transform.scale(scale: scale, child: child),
            ),
          ),
        );
      },
      // This is mostly just used to update the "Next Card" button to say
      // "Shuffle Deck" when the last card is selected.
      onSelectedItemChanged: (i) => setState(() => _selectedIndex = i),
      children: items,
    );
  }

  Widget _buildNextBtn() {
    return GestureDetector(
      onTap: () {
        if (_selectedIndex == 0) {
          _shuffleDeck();
        } else {
          _controller.previousItem(duration: 1000.ms);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF4CB1BE),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          _selectedIndex == 0 ? 'Shuffle Deck' : 'Next Card',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _shuffleDeck() {
    setState(() {
      _cardIndexes = _cardIndexes.sublist(1);
      _cardIndexes.shuffle();
      _cardIndexes.insert(0, 0);
      _controller.animateToItem(_cardIndexes.length - 1, duration: 800.ms);
    });
  }
}

class _Card extends StatelessWidget {
  const _Card(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    Widget card = AspectRatio(
      aspectRatio: 2 / 3,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/card_deck/card-$index.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const HSLColor.fromAHSL(1, 0, 1, 1).toColor(),
            width: 20,
          ),
        ),
      ),
    );

    return card;
  }
}
