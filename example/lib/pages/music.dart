import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

List<String> get images => [
  "https://thumbs.dreamstime.com/b/fantasy-coastal-city-perched-rocky-cliff-surrounded-nature-water-beautiful-cloud-formations-above-fantasy-coastal-347906628.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmIwMUGlWVd_YWs6jZ6cTxeqvzM9IOUmqZ0Q&s",
  "https://cdn.pixabay.com/photo/2023/08/11/18/06/ai-generated-8184109_1280.png",
  "https://creator.nightcafe.studio/jobs/ZNJjWr5ahVGZvCmUi6OL/ZNJjWr5ahVGZvCmUi6OL--1--I2UGS.jpg",
  "https://vitalentum.net/upload/007/u730/2/d/dark-fantasy-castle-and-moon-photo-photos-big.webp",
];

class MusicApp extends StatefulWidget {
  const MusicApp({super.key});

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final systemUiInsets = MediaQuery.of(context).padding;

    return DefaultSheetController(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: _BottomNavigationBar(),
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              SafeArea(
                bottom: false,
                child: SizedBox.expand(child: MusicPage()),
              ),

              _ContentSheet(systemUiInsets: systemUiInsets),
            ],
          ),
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
        final handleHeight = 64;
        final sheetHeight = parentHeight - appbarHeight + handleHeight;
        final minSheetOffset = SheetOffset.absolute(
          handleHeight + systemUiInsets.bottom,
        );

        return SheetViewport(
          child: Sheet(
            initialOffset: minSheetOffset,
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
              child: AnimatedBuilder(
                animation: DefaultSheetController.of(context),
                builder: (context, child) => SingleChildScrollView(
                  child: Player(
                    percentageOpen: SheetOffsetDrivenAnimation(
                      controller: DefaultSheetController.of(context),
                      initialValue: 0,
                    ).value,
                  ),
                ),
              ),
            ),
          ),
        );
      },
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

const coverImage =
    "https://cdn-s-www.ledauphine.com/images/C4A2656A-FDD7-40A0-A8F3-414D00B3A519/NW_raw/ariana-grande-en-janvier-2020-photo-frazer-harrison-getty-images-for-the-recording-academy-afp-1621312560.jpg";

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final _controller = ScrollController();
  double _offset = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(moveOffset);
  }

  void moveOffset() {
    setState(() {
      _offset = min(max(0, _controller.offset / 6 - 16), 32);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(moveOffset);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 240,
          collapsedHeight: 90,
          stretch: true,
          backgroundColor: Colors.black,
          foregroundColor: Colors.transparent,
          flexibleSpace: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            child: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Image.network(coverImage, fit: BoxFit.cover),
              expandedTitleScale: 1,
              titlePadding: const EdgeInsets.all(24),
              title: const Title(),
            ),
          ),
        ),
        // Used to get the stretch effect to not be above the SliverAppBar
        const SliverToBoxAdapter(),
        SliverAppBar(
          backgroundColor: context.cSur,
          // toolbarHeight: _offset + kToolbarHeight,
          title: Column(
            children: [
              // SizedBox(height: _offset),
              const DefaultTabController(
                length: 4,
                child: TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.white,
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(text: 'Popular'),
                    Tab(text: 'Albums'),
                    Tab(text: 'Songs'),
                    Tab(text: 'Fans also like'),
                  ],
                ),
              ),
            ],
          ),
          primary: false,
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((
            BuildContext context,
            int index,
          ) {
            return SongTile(index: index);
          }, childCount: listArianaGrandeAlbums.length),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }
}

class Player extends StatelessWidget {
  const Player({super.key, required this.percentageOpen});

  final double percentageOpen;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final imageHeight = 64 + (percentageOpen * height * 0.5);

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height),
      child: Stack(
        children: <Widget>[
          Container(color: context.cSur2, height: height),

          //
          Opacity(
            opacity: max(0, 1 - (percentageOpen * 4)),
            child: SizedBox(
              height: 64,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 64),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Thank u, Next',
                          style: TextStyle(color: context.cOnSur),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Ariana Grande',
                          style: TextStyle(color: context.cSur8),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () {},
                      color: context.cOnSur,
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.skip_next),
                      onPressed: () {},
                      color: context.cOnSur,
                    ),
                  ],
                ),
              ),
            ),
          ),

          //
          Opacity(
            opacity: percentageOpen > 0.5
                ? min(1, max(0, percentageOpen - 0.5) * 2)
                : 0,
            child: Column(
              children: [
                SizedBox(height: imageHeight * 0.9),

                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.thumb_down_alt_outlined,
                      size: 20,
                      color: context.cOnSur,
                    ),
                    Column(
                      children: [
                        Text(
                          'Thank u, Next',
                          style: TextStyle(
                            color: context.cOnSur,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ariana Grande',
                          style: TextStyle(color: context.cSur9),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.thumb_up_alt_outlined,
                      size: 20,
                      color: context.cOnSur,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Container(
                    height: 3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: context.cSur5,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0:00', style: TextStyle(color: context.cSur8)),
                      Text('3:27', style: TextStyle(color: context.cSur8)),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.shuffle, size: 32, color: context.cSur9),
                      Icon(Icons.skip_previous, size: 32, color: context.cSur9),
                      Container(
                        decoration: BoxDecoration(
                          color: context.cSur9,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.play_arrow,
                            size: 42,
                            color: context.cSur,
                          ),
                        ),
                      ),
                      Icon(Icons.skip_next, size: 32, color: context.cSur9),
                      Icon(Icons.repeat, size: 32, color: context.cSur9),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //
          Container(
            height: imageHeight,
            padding: const EdgeInsets.all(8.0),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
              child: Image.network(listArianaGrandeAlbums[1].albumCoverUrl),
            ),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ARTIST", style: TextStyle(color: context.cSur8, fontSize: 12)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                "Ariana Grande",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(width: 8),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(color: Colors.white, height: 10, width: 10),
                  const Icon(Icons.verified, color: Colors.blue),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Text(
                "62,354,659",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              SizedBox(width: 8),
              Text(
                "Monthly listeners",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SongTile extends StatefulWidget {
  const SongTile({super.key, required this.index});

  final int index;

  @override
  State<SongTile> createState() => _SongTileState();
}

class _SongTileState extends State<SongTile> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    final album = listArianaGrandeAlbums[widget.index];

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('#${widget.index + 1}', style: context.h6.c(context.cSur9)),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(album.albumCoverUrl, fit: BoxFit.cover),
            ),
          ],
        ),
        title: Text(album.albumName, style: context.h8.w5),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Row(
            children: [
              Icon(Icons.headphones, color: context.cSur9, size: 15),
              const SizedBox(width: 4),
              Text(
                '63,527,129',
                style: TextStyle(color: context.cSur9, fontSize: 13),
              ),
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  selected = !selected;
                });
              },
              icon: Icon(
                selected ? Icons.favorite : Icons.favorite_border,
                color: selected ? context.cTer : context.cOnSur,
              ),
            ),
            Icon(Icons.more_horiz, color: context.cOnSur),
          ],
        ),
      ),
    );
  }
}

class AlbumInfos {
  AlbumInfos(this.albumName, this.albumCoverUrl);

  final String albumName;
  final String albumCoverUrl;
}

final listArianaGrandeAlbums = [
  AlbumInfos(
    'Positions',
    'https://upload.wikimedia.org/wikipedia/en/a/a0/Ariana_Grande_-_Positions.png',
  ),
  AlbumInfos(
    'Thank u, Next',
    'https://upload.wikimedia.org/wikipedia/en/d/dd/Thank_U%2C_Next_album_cover.png',
  ),
  AlbumInfos(
    'Sweetener',
    'https://upload.wikimedia.org/wikipedia/en/7/7a/Sweetener_album_cover.png',
  ),
  AlbumInfos(
    'Dangerous Woman',
    'https://upload.wikimedia.org/wikipedia/en/4/4b/Ariana_Grande_-_Dangerous_Woman_%28Official_Album_Cover%29.png',
  ),
  AlbumInfos(
    'My Everything',
    'https://upload.wikimedia.org/wikipedia/en/d/d5/Ariana_Grande_My_Everything_2014_album_artwork.png',
  ),
  AlbumInfos(
    'Yours Truly',
    'https://upload.wikimedia.org/wikipedia/en/c/cb/Ariana_Grande_-_Yours_Truly.png',
  ),
  AlbumInfos(
    'Positions',
    'https://upload.wikimedia.org/wikipedia/en/a/a0/Ariana_Grande_-_Positions.png',
  ),
  AlbumInfos(
    'Thank u, Next',
    'https://upload.wikimedia.org/wikipedia/en/d/dd/Thank_U%2C_Next_album_cover.png',
  ),
  AlbumInfos(
    'Sweetener',
    'https://upload.wikimedia.org/wikipedia/en/7/7a/Sweetener_album_cover.png',
  ),
  AlbumInfos(
    'Dangerous Woman',
    'https://upload.wikimedia.org/wikipedia/en/4/4b/Ariana_Grande_-_Dangerous_Woman_%28Official_Album_Cover%29.png',
  ),
  AlbumInfos(
    'My Everything',
    'https://upload.wikimedia.org/wikipedia/en/d/d5/Ariana_Grande_My_Everything_2014_album_artwork.png',
  ),
  AlbumInfos(
    'Yours Truly',
    'https://upload.wikimedia.org/wikipedia/en/c/cb/Ariana_Grande_-_Yours_Truly.png',
  ),
];
