import 'package:example/carousel/circularcarousel.dart';
import 'package:example/carousel/contactListPage.dart';
import 'package:example/carousel/flutter_custom_carousel/views/card_deck_view.dart';
import 'package:example/carousel/flutter_custom_carousel/views/card_rotate_view.dart';
import 'package:example/carousel/flutter_custom_carousel/views/circle_cover.dart';
import 'package:example/carousel/flutter_custom_carousel/views/circle_single_card.dart';
import 'package:example/carousel/flutter_custom_carousel/views/circular_menu_view.dart';
import 'package:example/carousel/flutter_custom_carousel/views/cover_slider_view.dart';
import 'package:example/carousel/flutter_custom_carousel/views/digital_wallet_view.dart';
import 'package:example/carousel/flutter_custom_carousel/views/coverflow.dart';
import 'package:example/carousel/flutter_custom_carousel/views/opacity_stack.dart';
import 'package:example/carousel/flutter_custom_carousel/views/read_me_example.dart';
import 'package:example/carousel/flutter_custom_carousel/views/record_box_view.dart';
import 'package:example/carousel/flutter_custom_carousel/views/rotate.dart';
import 'package:example/carousel/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_carousel/flutter_custom_carousel.dart';

class Carouselmain extends StatelessWidget {
  const Carouselmain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0),
          child: Column(
            children: [
              Parallax(),

              CarouselExample(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("PerspectiveListView"),
              ),
              SizedBox(
                height: 400,
                width: 400,
                child: ClipRRect(
                  child: PerspectiveListView(
                    visualizedItems: 10,
                    itemExtent: 200,
                    initialIndex: 7,
                    backItemsShadowColor: Theme.of(
                      context,
                    ).scaffoldBackgroundColor,
                    padding: const EdgeInsets.all(10),
                    children: List.generate(Contact.contacts.length, (index) {
                      final contact = Contact.contacts[index];
                      final borderColor =
                          Colors.accents[index % Colors.accents.length];
                      return ContactCard(
                        borderColor: borderColor,
                        contact: contact,
                      );
                    }),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("CustomCarousel"),
              ),
              ClipRRect(
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: CustomCarousel(
                    alignment: Alignment.center,
                    itemCountBefore: 2,
                    itemCountAfter: 2,
                    scrollSpeed: 1.5,
                    loop: true,
                    effectsBuilder: CustomCarousel.effectsBuilderFromAnimate(
                      effects: EffectList()
                          .shimmer(
                            delay: 60.ms,
                            duration: 140.ms,
                            color: Colors.white38,
                            angle: 0.3,
                          )
                          .blurXY(delay: 0.ms, duration: 100.ms, begin: 8)
                          .blurXY(delay: 100.ms, end: 8)
                          .slideY(
                            delay: 0.ms,
                            duration: 200.ms,
                            begin: -3,
                            end: 3,
                          )
                          .flipH(begin: -0.3, end: 0.3),
                    ),
                    children: Colors.primaries.map((c) {
                      return AspectRatio(
                        aspectRatio: 1,
                        child: Container(color: c),
                      );
                    }).toList(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("OpacityStack"),
              ),
              RepaintBoundary(
                child: ClipRRect(
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: OpacityStack(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("CircleSingle"),
              ),
              RepaintBoundary(
                child: ClipRRect(
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: CircleSingle(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("CircleCover"),
              ),
              RepaintBoundary(
                child: ClipRRect(
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: CircleCover(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("CardDeckView"),
              ),
              RepaintBoundary(
                child: ClipRRect(
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: CardDeckView(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("CircularMenuView"),
              ),
              RepaintBoundary(
                child: ClipRRect(
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: CircularMenuView(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("CoverSliderView"),
              ),
              RepaintBoundary(
                child: ClipRRect(
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: CoverSliderView(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("CardRotateView"),
              ),
              RepaintBoundary(
                child: ClipRRect(
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: CardRotateView(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("CoverFlowCarouselPage"),
              ),
              RepaintBoundary(
                child: ClipRRect(
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: CoverFlowCarouselPage(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("DigitalWalletView"),
              ),
              RepaintBoundary(
                child: ClipRRect(
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: DigitalWalletView(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("ReadMeExample"),
              ),
              RepaintBoundary(
                child: ClipRRect(
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: ReadMeExample(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("RecordBoxView"),
              ),
              RepaintBoundary(
                child: ClipRRect(
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: RecordBoxView(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("RotateCoverFlowCarouselPage"),
              ),
              RepaintBoundary(
                child: ClipRRect(
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: RotateCoverFlowCarouselPage(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("CircularCarousel"),
              ),
              SizedBox(
                height: 400,
                width: 400,
                child: CircularCarousel(
                  // radius: 20, // Optional: fixed radius
                  radiusMultiplier: 0.3, // Optional: percentage of screen width
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarouselExample extends StatefulWidget {
  const CarouselExample({super.key});

  @override
  State<CarouselExample> createState() => _CarouselExampleState();
}

class _CarouselExampleState extends State<CarouselExample> {
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;

    return Column(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: height / 2),
          child: CarouselView.weighted(
            controller: controller,
            itemSnapping: true,
            flexWeights: const <int>[1, 7, 1],
            children: ImageInfo.values.map((ImageInfo image) {
              return HeroLayoutCard(imageInfo: image);
            }).toList(),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 50),
          child: CarouselView.weighted(
            flexWeights: const <int>[1, 2, 3, 2, 1],
            consumeMaxWeight: false,
            children: List<Widget>.generate(20, (int index) {
              return ColoredBox(
                color: Colors.primaries[index % Colors.primaries.length],
                child: const SizedBox.expand(),
              );
            }),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints.tightFor(height: 150),
          child: CarouselView(
            itemSnapping: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Theme.of(context).colorScheme.outline),
            ),
            shrinkExtent: 50,
            itemExtent: 200,
            children: List<Widget>.generate(20, (index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.primaries[index % Colors.primaries.length]
                    .withAlpha(20),
                child: Text('Item $index'),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({super.key, required this.imageInfo});

  final ImageInfo imageInfo;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        ClipRect(
          child: OverflowBox(
            maxWidth: width * 7 / 8,
            minWidth: width * 7 / 8,
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/material/${imageInfo.url}',
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                imageInfo.title,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                imageInfo.subtitle,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum ImageInfo {
  image0(
    'The Flow',
    'Sponsored | Season 1 Now Streaming',
    'content_based_color_scheme_1.png',
  ),
  image1(
    'Through the Pane',
    'Sponsored | Season 1 Now Streaming',
    'content_based_color_scheme_2.png',
  ),
  image2(
    'Iridescence',
    'Sponsored | Season 1 Now Streaming',
    'content_based_color_scheme_3.png',
  ),
  image3(
    'Sea Change',
    'Sponsored | Season 1 Now Streaming',
    'content_based_color_scheme_4.png',
  ),
  image4(
    'Blue Symphony',
    'Sponsored | Season 1 Now Streaming',
    'content_based_color_scheme_5.png',
  ),
  image5(
    'When It Rains',
    'Sponsored | Season 1 Now Streaming',
    'content_based_color_scheme_6.png',
  );

  const ImageInfo(this.title, this.subtitle, this.url);
  final String title;
  final String subtitle;
  final String url;
}
