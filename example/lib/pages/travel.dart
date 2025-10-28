import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

List<String> get images => [
  "https://thumbs.dreamstime.com/b/fantasy-coastal-city-perched-rocky-cliff-surrounded-nature-water-beautiful-cloud-formations-above-fantasy-coastal-347906628.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmIwMUGlWVd_YWs6jZ6cTxeqvzM9IOUmqZ0Q&s",
  "https://cdn.pixabay.com/photo/2023/08/11/18/06/ai-generated-8184109_1280.png",
  "https://creator.nightcafe.studio/jobs/ZNJjWr5ahVGZvCmUi6OL/ZNJjWr5ahVGZvCmUi6OL--1--I2UGS.jpg",
  "https://vitalentum.net/upload/007/u730/2/d/dark-fantasy-castle-and-moon-photo-photos-big.webp",
];

class TravelApp extends StatefulWidget {
  const TravelApp({super.key});

  @override
  State<TravelApp> createState() => _TravelAppState();
}

class _TravelAppState extends State<TravelApp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final systemUiInsets = MediaQuery.of(context).padding;

    return DefaultTabController(
      length: _AppBar.tabs.length,
      child: DefaultSheetController(
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: _BottomNavigationBar(),
          floatingActionButton: const _MapButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: _AppBar(),
          body: Form(
            key: _formKey,
            child: Stack(
              children: [
                SafeArea(
                  bottom: false,
                  child: SizedBox.expand(child: TravelCard(index: 0)),
                ),

                _ContentSheet(systemUiInsets: systemUiInsets),
              ],
            ),
            // child: CustomScrollView(
            //   slivers: [
            //     SliverAppBar(
            //       pinned: true,
            //       leading: IconButton(
            //         onPressed: () {
            //           context.pop();
            //         },
            //         icon: Icon(
            //           CupertinoIcons.chevron_left,
            //           color: context.cs.onSurface,
            //         ),
            //       ),
            //       actions: [
            //         IconButton(
            //           onPressed: () {},
            //           icon: Icon(
            //             CupertinoIcons.heart,
            //             color: context.cs.onSurface,
            //           ),
            //         ),
            //         SizedBox(width: 8),
            //       ],
            //     ),
            //     SliverToBoxAdapter(
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             CurvedCarousel(
            //               height: 250,
            //               width: context.mq.w * .85,
            //               rotationMultiplier: 0,
            //               yMultiplier: 0,
            //               opacityMin: 1,
            //               scaleMin: 1,
            //               count: images.length,
            //               builder: (index) => InkWell(
            //                 onTap: () {},
            //                 child: Material(
            //                   color: Colors.transparent,
            //                   child: CustomCacheImage(
            //                     imageUrl: images[index],
            //                     borderRadius: 24,
            //                   ),
            //                 ),
            //               ),
            //             ),

            //             const SizedBox(height: 16),

            //             Text("Travel", style: context.h4.w6),

            //             Text("Destiny"),

            //             const SizedBox(height: 8),

            //             Sherlock<String>(
            //               bar: true,
            //               hint: "Where to",
            //               barColor: context.cs.surface,
            //               border: 1.bRound.c(context.cSur8).r(12),
            //               fetch: (query) async {
            //                 await Future.delayed(1.sec);
            //                 return [
            //                   "Apple",
            //                   "Lemon",
            //                   "Orange",
            //                 ].where((q) => q.contains(query)).toList();
            //               },
            //               icon: Icon(Icons.location_on),
            //               builder: (data, controller) {
            //                 return ListView.builder(
            //                   shrinkWrap: true,
            //                   clipBehavior: Clip.antiAlias,
            //                   itemCount: data.length,
            //                   itemBuilder: (con, index) => Card(
            //                     child: ListTile(
            //                       title: Text(data[index]),
            //                       onTap: () {},
            //                     ),
            //                   ),
            //                 );
            //               },
            //             ),

            //             SizedBox(height: 16),

            //             CurvedCarousel(
            //               height: 170,
            //               width: 200,
            //               rotationMultiplier: 0,
            //               yMultiplier: 0,
            //               opacityMin: 1,
            //               scaleMin: 1,
            //               count: images.length,
            //               alignment: Alignment.centerLeft,
            //               builder: (index) => TravelCard(index: index),
            //             ),

            //             const SizedBox(height: 8),
            //           ],
            //         ),
            //       ),
            //     ),

            //     SliverList.builder(
            //       itemCount: images.length,
            //       itemBuilder: (context, index) {
            //         return SizedBox(
            //           height: 250,
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: TravelCard(index: index),
            //           ),
            //         );
            //       },
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}

class TravelCard extends StatelessWidget {
  const TravelCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: 220,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomCacheImage(
                      imageUrl: images[index],
                      borderRadius: 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Witch Island", style: context.h7.w5),
                      Text("4.8", style: context.p.c(context.cSur9)),
                    ],
                  ),
                  Text("Island witch", style: context.p.c(context.cSur9)),
                ],
              ),

              Align(
                alignment: Alignment(0.9, -0.9),
                child: Icon(CupertinoIcons.heart, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCacheImage extends StatelessWidget {
  const CustomCacheImage({
    super.key,
    required this.imageUrl,
    this.borderRadius = 0,
    this.showError = false,
    this.gradient,
  });

  final String imageUrl;
  final double borderRadius;
  final bool showError;
  final Gradient? gradient; // Optional gradient parameter

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const SizedBox(),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
          ),
          if (gradient != null) // Check if a gradient is provided
            Container(
              decoration: BoxDecoration(
                gradient: gradient, // Apply the gradient
              ),
            ),
        ],
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  const _MapButton();

  @override
  Widget build(BuildContext context) {
    final sheetController = DefaultSheetController.of(context);

    final animation = SheetOffsetDrivenAnimation(
      controller: DefaultSheetController.of(context),
      initialValue: 1,
      startOffset: null,
      endOffset: null,
    ).drive(CurveTween(curve: Curves.easeInExpo));

    return ScaleTransition(
      scale: animation,
      child: FadeTransition(
        opacity: animation,
        child: FloatingActionButton.extended(
          onPressed: () {
            if (sheetController.metrics case final it?) {
              // Collapse the sheet to reveal the map behind.
              sheetController.animateTo(
                SheetOffset.absolute(it.minOffset),
                curve: Curves.fastOutSlowIn,
              );
            }
          },
          label: const Text('Map'),
          icon: const Icon(Icons.map),
        ),
      ),
    );
  }
}

class _ContentSheet extends StatelessWidget {
  const _ContentSheet({required this.systemUiInsets});

  final EdgeInsets systemUiInsets;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final parentHeight = constraints.maxHeight;
        final appbarHeight = MediaQuery.of(context).padding.top;
        final handleHeight = const _ContentSheetHandle().preferredSize.height;
        final sheetHeight = parentHeight - appbarHeight + handleHeight;
        final minSheetOffset = SheetOffset.absolute(
          handleHeight + systemUiInsets.bottom,
        );

        return SheetViewport(
          child: Sheet(
            scrollConfiguration: const SheetScrollConfiguration(),
            snapGrid: SheetSnapGrid(
              snaps: [minSheetOffset, const SheetOffset(1)],
            ),
            decoration: const MaterialSheetDecoration(
              size: SheetSize.fit,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
            child: SizedBox(
              height: sheetHeight,
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: DefaultSheetController.of(context),
                    builder: (context, child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${SheetOffsetDrivenAnimation(controller: DefaultSheetController.of(context), initialValue: 1).value}',
                        ),
                      );
                    },
                  ),
                  _ContentSheetHandle(),
                  Expanded(child: _HouseList()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ContentSheetHandle extends StatelessWidget
    implements PreferredSizeWidget {
  const _ContentSheetHandle();

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: preferredSize,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(height: 6, width: 40, color: context.cTer),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Text(
                  '646 national park homes',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  static const tabs = [
    Tab(text: 'National parks', icon: Icon(Icons.forest_outlined)),
    Tab(text: 'Tiny homes', icon: Icon(Icons.cabin_outlined)),
    Tab(text: 'Ryokan', icon: Icon(Icons.hotel_outlined)),
    Tab(text: 'Play', icon: Icon(Icons.celebration_outlined)),
  ];

  static const topHeight = 90.0;
  static const bottomHeight = 72.0;

  @override
  Size get preferredSize => const Size.fromHeight(topHeight + bottomHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: context.cSur,
      toolbarHeight: topHeight,
      bottom: const TabBar(tabs: tabs),
      title: SizedBox(
        height: topHeight,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: ShapeDecoration(
                  color: context.cSur,
                  shape: StadiumBorder(side: BorderSide(color: context.cSur5)),
                  shadows: [
                    BoxShadow(
                      color: context.cs.surfaceTint.withAlpha(50),
                      spreadRadius: 4,
                      blurRadius: 8,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.search),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Where to?',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Anywhere · Any week · Add guest',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.p,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            IconButton(onPressed: () {}, icon: const Icon(Icons.tune_outlined)),
          ],
        ),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    final result = BottomNavigationBar(
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined),
          label: 'Wishlists',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.luggage_outlined),
          label: 'Trips',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inbox_outlined),
          label: 'Inbox',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );

    // Hide the navigation bar when the sheet is dragged down.
    return SlideTransition(
      position: SheetOffsetDrivenAnimation(
        controller: DefaultSheetController.of(context),
        initialValue: 1,
      ).drive(Tween(begin: const Offset(0, 1), end: Offset.zero)),
      child: result,
    );
  }
}

class _HouseList extends StatelessWidget {
  const _HouseList();

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: SheetOffsetDrivenAnimation(
        controller: DefaultSheetController.of(context),
        initialValue: 1,
      ).drive(CurveTween(curve: Curves.easeOutCubic)),

      //
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: AspectRatio(
              aspectRatio: 1.2,
              // child: Image.network(house.image, fit: BoxFit.fitWidth),
              child: TravelCard(index: index),
            ),
          );
        },
      ),
    );
  }
}
