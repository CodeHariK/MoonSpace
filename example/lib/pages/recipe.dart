import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moonspace/carousel/curved_carousel.dart';
import 'package:moonspace/form/select.dart';
import 'package:moonspace/helper/extensions/color.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';
import 'package:moonspace/theme.dart';
import 'package:moonspace/widgets/expandable_text.dart';
import 'package:moonspace/widgets/ratings.dart';

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Desserts',
          style: GoogleFonts.alice(textStyle: context.h2),
        ),
        centerTitle: false,

        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.clear, size: 16),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        onTap: (value) {
          if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CheckoutCartPage()),
            );
          } else if (value == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReviewPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Review',
          ),
        ],
      ),
      body: RecipeListView(),
    );
  }
}

class RecipeListView extends StatefulWidget {
  const RecipeListView({super.key});

  @override
  State<RecipeListView> createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView> {
  bool downScroll = true; // Default flip value

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          setState(() {
            downScroll = notification.scrollDelta! > 0;
          });
        }
        return true;
      },
      child: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   pinned: true,
          //   floating: false,
          //   automaticallyImplyLeading: false,
          //   snap: false,
          //   toolbarHeight: 50,
          //   flexibleSpace: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           'Desserts',
          //           style: GoogleFonts.alice(textStyle: context.h2),
          //         ),
          //         IconButton(
          //           icon: const Icon(CupertinoIcons.clear, size: 16),
          //           onPressed: () => Navigator.of(context).pop(),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          //     child: GridView.count(
          //       crossAxisCount: 3,
          //       shrinkWrap: true,
          //       mainAxisSpacing: 8,
          //       crossAxisSpacing: 8,
          //       physics: NeverScrollableScrollPhysics(),
          //       children: RecipesData.dessertMenu
          //           .take(6)
          //           .map(
          //             (e) => ClipRRect(
          //               borderRadius: BorderRadiusGeometry.circular(8),
          //               child: Container(
          //                 color: context.cSur3,
          //                 child: Image.asset(
          //                   e.image,
          //                   scale: 8,
          //                   alignment: Alignment(-2.2, -2.2),
          //                   fit: BoxFit.none,
          //                 ),
          //               ),
          //             ),
          //           )
          //           .toList(),
          //     ),
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          //     child: Text(
          //       "Categories",
          //       style: GoogleFonts.alice(textStyle: context.h4),
          //     ),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ClipRRect(
                child: CurvedCarousel(
                  height: 160,
                  itemCountBefore: context.r(2, 3, 4, 5, 5, 5).toInt(),
                  itemCountAfter: context.r(2, 3, 4, 5, 5, 5).toInt(),
                  // width: context.mq.w,
                  rotationMultiplier: 0,
                  xMultiplier: context
                      .r(2.2, (3.1, 3.2).c, 4, 4.8, 5, 6)
                      .toDouble(),
                  yMultiplier: 0,
                  opacityMin: 1,
                  scaleMin: 1,
                  alignment: Alignment.centerLeft,
                  count: RecipesData.dessertMenu.length,
                  animatedBuilder: (index, ratio) {
                    return SizedBox(
                      key: ValueKey(index),
                      width: 140,
                      child: GestureDetector(
                        onTap: () {
                          // final continent = RecipesData.dessertMenu[index];
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Container(
                              height: 125,
                              decoration: BoxDecoration(
                                color: context.cSur4,
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                0,
                                16,
                                56.0,
                              ),
                              child: Transform.rotate(
                                angle: ratio * 5,
                                child: Image.asset(
                                  RecipesData.dessertMenu[index].image,
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          RecipesData.dessertMenu[index].title,
                                          textAlign: TextAlign.start,
                                          style: context.h9,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          "\$8",
                                          textAlign: TextAlign.start,
                                          style: context.h9,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    isSelected: index % 2 == 1,
                                    icon: Icon(CupertinoIcons.heart),
                                    selectedIcon: Icon(
                                      CupertinoIcons.heart_fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                "Best Prices",
                style: GoogleFonts.alice(textStyle: context.h4),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.r(1, 1, 2, 2, 3, 4).toInt(),
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: context
                    .r(1.4, 1.8, 1.8, 1.8, 1.8, 1.8)
                    .toDouble(),
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return RecipeCard(
                  index: index % RecipesData.dessertMenu.length,
                  delayMs: 0,
                  downScroll: downScroll,
                );
              }, childCount: RecipesData.dessertMenu.length * 10),
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.index,
    required this.delayMs,
    required this.downScroll,
  });

  final int index;
  final double delayMs;
  final bool downScroll;

  @override
  Widget build(BuildContext context) {
    final recipe = RecipesData.dessertMenu[index];
    final delay = (delayMs * index).ms;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipePage(index: index)),
        );
      },
      child:
          Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: recipe.bgColor,
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RecipeTitle(index: index, sliver: false),
                          RecipeSubtitle(index: index, sliver: false),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child:
                          RecipeImage(delay: delay, index: index, sliver: false)
                              .animate()
                              .scale(end: Offset(1.1, 1.1))
                              .rotate(
                                delay: delay,
                                alignment: Alignment.center,
                                duration: 400.ms,
                                begin: 0.4,
                                end: 0,
                              )
                              .move(end: Offset(20, 20)),
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(delay: delay, duration: 300.ms)
              .flipV(begin: downScroll ? .5 : -.5, end: 0),
    );
  }
}

class RecipeTitle extends StatelessWidget {
  const RecipeTitle({super.key, required this.index, required this.sliver});
  final int index;
  final bool sliver;

  @override
  Widget build(BuildContext context) {
    final recipe = RecipesData.dessertMenu[index];

    return Hero(
      tag: "RecipeTitle-$index",
      child: Text(
        recipe.title,
        style: GoogleFonts.alice(
          textStyle: context.h2.w5.c(
            sliver ? context.cOnSur : recipe.bgColor.getOnColor(),
          ),
        ),
        maxLines: 2,
      ),
    );
  }
}

class RecipeSubtitle extends StatelessWidget {
  const RecipeSubtitle({super.key, required this.index, required this.sliver});
  final int index;
  final bool sliver;

  @override
  Widget build(BuildContext context) {
    final recipe = RecipesData.dessertMenu[index];

    return Hero(
      tag: "RecipeSubtitle-$index",
      child: Text(
        recipe.description,
        style: context.h8.c(
          sliver ? context.cOnSur : recipe.bgColor.getOnColor(),
        ),
        maxLines: 3,
      ),
    );
  }
}

class RecipeImage extends StatelessWidget {
  const RecipeImage({
    super.key,
    required this.delay,
    required this.index,
    required this.sliver,
  });

  final Duration delay;
  final int index;
  final bool sliver;

  // static double size(bool sliver) => sliver ? 270 : 200;

  @override
  Widget build(BuildContext context) {
    final recipe = RecipesData.dessertMenu[index];
    return Container(
      padding: sliver ? EdgeInsets.all(10) : null,
      child: Hero(tag: "RecipeImage-$index", child: Image.asset(recipe.image)),
    );
  }
}

class RecipePage extends StatefulWidget {
  const RecipePage({super.key, required this.index});

  final int index;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final controller = ScrollController();

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipe = RecipesData.dessertMenu[widget.index];

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: recipe.bgColor,
        onPressed: () {},
        label: Text("Order now"),
      ),
      body: context.widthM2
          ? _scroll(recipe, context)
          : Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: recipe.bgColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                        ),
                        child: _img(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilledButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.all(24),
                            textStyle: context.h7,
                            shape: 0.bRound.r(32).c(Colors.transparent),
                          ),
                          label: Text("Back to Recipes"),
                          icon: Icon(CupertinoIcons.arrow_left),
                        ),
                      ).animate().scale(),
                    ],
                  ),
                ),
                Expanded(child: _scroll(recipe, context)),
              ],
            ),
    );
  }

  Widget _scroll(Recipe recipe, BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: [
        if (context.widthM2)
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton.filled(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: IconButton.styleFrom(backgroundColor: context.cSur),
                icon: Icon(CupertinoIcons.arrow_left),
              ).animate().scale(),
            ),
            pinned: true,
            collapsedHeight: 150,
            expandedHeight: 300,
            backgroundColor: recipe.bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.vertical(
                bottom: Radius.circular(32),
              ),
            ),
            flexibleSpace: _img(),
          ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                RecipeTitle(index: widget.index, sliver: true),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Text("3.6  ", style: context.h6),
                    MaskedRatingBar(rating: 3.6, filledColor: recipe.bgColor),
                  ],
                ),

                const SizedBox(height: 8),

                RecipeSubtitle(index: widget.index, sliver: true),

                const SizedBox(height: 16),

                Text('INGREDIENTS', style: context.h6.w5),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ),

        SliverRecipeList(recipe: recipe, ingredients: true),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('STEPS', style: context.h6.w5),
          ),
        ),

        SliverRecipeList(recipe: recipe, ingredients: false),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 240,
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 3,
                    children: List.generate(4, (index) {
                      return ListTile(
                        onTap: () {},
                        contentPadding: EdgeInsets.symmetric(horizontal: 4),
                        leading: Icon(CupertinoIcons.heart),
                        titleAlignment: ListTileTitleAlignment.top,
                        title: Text('Heart'),
                        dense: true,
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  shrinkWrap: true,
                  children: List.generate(6, (index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: context.cSur2,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.yard_outlined,
                            size: 50,
                            color: context.cSur9,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Item ${index + 1}',
                            style: context.h8.c(context.cSur9),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                Text(
                  'Mayan, Mexico',
                  style: GoogleFonts.ibmPlexMono(textStyle: context.h8),
                ),
                const SizedBox(height: 8),
                OptionBox(
                  options: [
                    Option(
                      value: "1",
                      title: Text("Home"),
                      secondary: Icon(CupertinoIcons.cloud_moon_rain),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mayan, Mexico"),
                          Text("Mayan, Mexico"),
                        ],
                      ),
                    ),
                    Option(
                      value: "2",
                      title: Text("Home"),
                      secondary: Icon(CupertinoIcons.cloud_moon_rain),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mayan, Mexico"),
                          Text("Mayan, Mexico"),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Center _img() {
    return Center(
      child: RecipeImage(
        delay: 1.ms,
        index: widget.index,
        sliver: true,
      ).animate(adapter: ScrollAdapter(controller)).rotate(),
    );
  }
}

class SliverRecipeList extends StatelessWidget {
  const SliverRecipeList({
    super.key,
    required this.recipe,
    required this.ingredients,
  });

  final Recipe recipe;
  final bool ingredients;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: ingredients
          ? recipe.ingredients.length
          : recipe.instructions.length,
      itemBuilder: (context, index) {
        return Container(
          // height: 50,
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: recipe.bgColor),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Stack(
            children: [
              CircleAvatar(
                    backgroundColor: recipe.bgColor,
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset('assets/desserts/chef.png'),
                    ),
                  )
                  .animate()
                  .rotate(duration: 400.ms, begin: .2, end: -.05)
                  .move(end: Offset(-20, -20)),
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 8, 8, 8),
                child: Text(
                  ingredients
                      ? recipe.ingredients[index]
                      : recipe.instructions[index],
                  style: context.h7.w3,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 400.ms).moveY(begin: 100, end: 0);
      },
    );
  }
}

class CheckoutCartPage extends StatefulWidget {
  const CheckoutCartPage({super.key});

  @override
  State<CheckoutCartPage> createState() => _CheckoutCartPageState();
}

class _CheckoutCartPageState extends State<CheckoutCartPage> {
  final font = GoogleFonts.robotoMono();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          children: [
            Text('Cart,', style: GoogleFonts.alice(textStyle: context.h2)),
            Text(
              ' 3 items',
              style: GoogleFonts.alice(textStyle: context.h2).c(context.cSur9),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.nav.pop();
            },
            icon: Icon(CupertinoIcons.clear, size: 16),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search desserts...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    // Open filter modal/sheet
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 125,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Promo Code',
                suffixIcon: TextButton(
                  onPressed: () {},
                  child: const Text('Apply'),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: Text('\$355.00', style: context.h5.w5)),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: FilledButton.tonal(
                    onPressed: () {},
                    child: const Text('Checkout'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = RecipesData.dessertMenu[index];

              return Container(
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: RecipeImage(
                        delay: 1.ms,
                        index: index,
                        sliver: false,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(item.title, style: context.h7),
                              ),
                              IconButton.outlined(
                                iconSize: 14,
                                constraints: BoxConstraints(
                                  maxHeight: 32,
                                  maxWidth: 32,
                                ),
                                padding: EdgeInsets.all(6),
                                icon: const Icon(CupertinoIcons.clear),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\$95.00',
                                    style: context.p.line.c(context.cSur8),
                                  ),
                                  Text('\$85.00', style: context.h7.w6),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: context.cSur2,
                                  borderRadius: 32.br,
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {},
                                    ),
                                    Text('1'),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }, childCount: RecipesData.dessertMenu.length),
          ),
        ],
      ),
    );
  }
}

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  Widget _buildReviewCard(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(child: Icon(Icons.person)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User $index', style: context.h8),
                      MaskedRatingBar(rating: 4.3),
                    ],
                  ),
                ),
                const Text('May 2025', style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            ExpandableText(
              'This is a review text. It may be long so it might need a read more option. '
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus convallis, '
              'massa nec tincidunt tincidunt, lorem nunc.',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.nav.pop();
          },
          icon: Icon(CupertinoIcons.arrow_left),
        ),
        title: Text('Reviews'),
        actions: [
          IconButton(
            onPressed: () {
              context.nav.pop();
            },
            icon: Icon(CupertinoIcons.option),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Write a Review'),
        icon: const Icon(Icons.edit),
      ),
      body: CustomScrollView(
        slivers: [
          // Ratings Summary
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Left column: average rating and count
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('4.9', style: context.h4),
                      Text('123 reviews', style: context.ls),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: RatingsBars(percentages: [.8, .6, .4, .2, .1]),
                  ),
                ],
              ),
            ),
          ),

          // Search and Filter
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(CupertinoIcons.search),
                        hintText: 'Search reviews...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateColor.resolveWith(
                        (e) => context.cOnSur,
                      ),
                      shape: WidgetStateOutlinedBorder.resolveWith(
                        (e) => 0.bRound.r(8),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.slider_horizontal_3),
                  ),
                ],
              ),
            ),
          ),

          // Review List
          SliverList.separated(
            itemBuilder: (context, index) => _buildReviewCard(context, index),
            // delegate: SliverChildBuilderDelegate(
            //   (context, index) => _buildReviewCard(context, index),
            //   childCount: 10,
            // ),
            itemCount: 10,
            separatorBuilder: (context, index) =>
                Divider(height: 0, indent: 30, endIndent: 30),
          ),

          // Spacer for bottom button
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}

///
///

class Recipe {
  final int id;
  final String title;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final String image;
  final String bgImageName;
  final Color bgColor;

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.image,
    required this.bgImageName,
    required this.bgColor,
  });

  String get bgImage =>
      bgImageName.isEmpty ? '' : 'assets/desserts/$bgImageName.png';

  String get bgImageLg =>
      bgImageName.isEmpty ? '' : 'assets/desserts/$bgImageName-lg.png';
}

class RecipesData {
  static const List<Recipe> dessertMenu = [
    Recipe(
      id: 1,
      title: 'Lemon Cheesecake',
      description:
          'Tart Lemon Cheesecake sits atop an almond-graham cracker crust to add a delightful nuttiness to the traditional graham cracker crust. Finish the cheesecake with lemon curd for double the tart pucker!',
      ingredients: [
        '110g digestive biscuits',
        '50g butter',
        '25g light brown soft sugar',
        '350g mascarpone',
        '75g caster sugar',
        '1 lemon, zested',
        '2-3 lemons, juiced (about 90ml)',
      ],
      instructions: [
        'Crush the digestive biscuits in a food bag with a rolling pin or in the food processor. Melt the butter in a saucepan, take off heat and stir in the brown sugar and biscuit crumbs.',
        'Line the base of a 20cm loose bottomed cake tin with baking parchment. Press the biscuit into the bottom of the tin and chill in the fridge while making the topping.'
            'Beat together the mascarpone, caster sugar, lemon zest and juice, until smooth and creamy. Spread over the base and chill for a couple of hours.',
      ],
      image: 'assets/desserts/01-lemon-cheesecake.png',
      bgImageName: '01-lemon-cheesecake-bg',
      bgColor: AppColors.yellow,
    ),
    Recipe(
      id: 2,
      title: 'Macaroons',
      description:
          'Soft and chewy on the inside, crisp and golden on the outside — these are the perfect macaroons.',
      ingredients: [
        '1 ¾ cups powdered sugar(210 g)',
        '1 cup almond flour(95 g), finely ground',
        '1 teaspoon salt, divided',
        '3 egg whites, at room temperature',
        '¼ cup granulated sugar(50 g)',
        '½ teaspoon vanilla extract',
        '2 drops pink gel food coloring',
      ],
      instructions: [
        'Make the macarons: In the bowl of a food processor, combine the powdered sugar, almond flour, and ½ teaspoon of salt, and process on low speed, until extra fine. Sift the almond flour mixture through a fine-mesh sieve into a large bowl.',
        'In a separate large bowl, beat the egg whites and the remaining ½ teaspoon of salt with an electric hand mixer until soft peaks form. Gradually add the granulated sugar until fully incorporated. Continue to beat until stiff peaks form (you should be able to turn the bowl upside down without anything falling out).',
        'Add the vanilla and beat until incorporated. Add the food coloring and beat until just combined.',
        'Add about ⅓ of the sifted almond flour mixture at a time to the beaten egg whites and use a spatula to gently fold until combined. After the last addition of almond flour, continue to fold slowly until the batter falls into ribbons and you can make a figure 8 while holding the spatula up.',
        'Transfer the macaron batter into a piping bag fitted with a round tip.',
        'Place 4 dots of the batter in each corner of a rimmed baking sheet, and place a piece of parchment paper over it, using the batter to help adhere the parchment to the baking sheet.',
        'Pipe the macarons onto the parchment paper in 1½-inch (3-cm) circles, spacing at least 1-inch (2-cm) apart.',
        'Tap the baking sheet on a flat surface 5 times to release any air bubbles.',
        'Let the macarons sit at room temperature for 30 minutes to 1 hour, until dry to the touch.',
        'Preheat the oven to 300˚F (150˚C).',
        'Bake the macarons for 17 minutes, until the feet are well-risen and the macarons don’t stick to the parchment paper.',
        'Transfer the macarons to a wire rack to cool completely before filling.',
        'Make the buttercream: In a large bowl, add the butter and beat with a mixer for 1 minute until light and fluffy. Sift in the powdered sugar and beat until fully incorporated. Add the vanilla and beat to combine. Add the cream, 1 tablespoon at a time, and beat to combine, until desired consistency is reached.',
        'Transfer the buttercream to a piping bag fitted with a round tip.',
        'Add a dollop of buttercream to one macaron shell. Top it with another macaron shell to create a sandwich. Repeat with remaining macaron shells and buttercream.',
        'Place in an airtight container for 24 hours to “bloom”.',
      ],
      image: 'assets/desserts/05-macaroons.png',
      bgImageName: '',
      bgColor: AppColors.primary,
    ),
    Recipe(
      id: 3,
      title: 'Cream Cupcakes',
      description:
          "Bake these easy vanilla cupcakes in just 35 minutes. Perfect for birthdays, picnics or whenever you fancy a sweet treat, they're sure to be a crowd-pleaser",
      ingredients: [''],
      instructions: [''],
      image: 'assets/desserts/08-cream-cupcakes.png',
      bgImageName: '',
      bgColor: AppColors.pinkLight,
    ),
    Recipe(
      id: 4,
      title: 'Chocolate Cheesecake',
      description:
          "Treat family and friends to this decadent chocolate dessert. It's an indulgent end to a dinner party or weekend family meal",
      ingredients: [
        '150g digestive biscuits (about 10)',
        '1 tbsp caster sugar',
        '45g butter, melted, plus extra for the tin',
        '150g dark chocolate',
        '120ml double cream',
        '2 tsp cocoa powder',
        '200g full-fat cream cheese',
        '115g caster sugar',
      ],
      instructions: [
        'To make the biscuit base, crush the digestive biscuits with a rolling pin or blitz in a food processor, then tip into a bowl with the sugar and butter and stir to combine. Butter and line an 18cm springform tin and tip in the biscuit mixture, pushing it down with the back of a spoon. Chill in the fridge for 30 mins.',
        'To make the cheesecake, melt the chocolate in short bursts in the microwave, then leave to cool slightly. Whip the cream in a large bowl using an electric whisk until soft peaks form, then fold in the cocoa powder. Beat the cream cheese and sugar together, then fold in the cream mixture and the cooled chocolate.',
        'Spoon the cheesecake mixture over the biscuit base, levelling it out with the back of a spoon. Transfer to the freezer and freeze for 2 hrs, or until set. Remove from the tin and leave at room temperature to soften for about 20 mins before serving.',
      ],
      image: 'assets/desserts/02-chocolate-cake-1.png',
      bgImageName: '',
      bgColor: AppColors.orangeDark,
    ),
    Recipe(
      id: 5,
      title: 'Fruit Plate',
      description:
          "Melons - they're firmer so make a great base for the softer berries and fruits. Tropical fruit - the top of a pineapple can be included for height, while dragonfruit looks vibrant.",
      ingredients: [''],
      instructions: [''],
      image: 'assets/desserts/09-fruit-plate.png',
      bgImageName: '',
      bgColor: AppColors.green,
    ),
    Recipe(
      id: 6,
      title: 'Chocolate Donuts',
      description:
          'Moist and fluffy donuts that are baked, not fried, and full of chocolate. Covered in a thick chocolate glaze, these are perfect for any chocoholic who wants a chocolate version of this classic treat.',
      ingredients: [
        '1 cup (140g) all-purpose flour',
        '1/4 cup (25g) unsweetened cocoa powder',
        '1/2 teaspoon baking powder',
        '1/2 teaspoon baking soda',
        '1/8 teaspoon salt',
        '1 large egg',
        '1/2 cup (100g) granulated sugar',
        '1/3 cup (80 ml) milk',
        '1/4 cup (60 ml) yogurt',
        '2 tablespoons (30g) unsalted butter, melted',
        '1/2 teaspoon vanilla extract',
      ],
      instructions: [
        'Preheat oven to 350°F/180°. Grease a donut pan with oil or butter. Set aside.',
        'Make the donuts: Whisk together the flour, cocoa powder, baking powder, baking soda, and salt in a large bowl. Set aside.',
        'In a medium bowl whisk egg with sugar until well combined. Add milk, yogurt, melted butter and vanilla extract, and whisk until combined. Pour into the flour mixture and mix until just combined. The batter will be thick.',
        'Fill donut cavities with batter ¾ way full using a spoon or a piping bag (much easier). Cut a corner off the bottom of the bag and pipe the batter into each donut cup.',
        'Bake for 9–10 minutes or until a toothpick inserted into the center of the donuts comes out clean. Allow to cool for 5 minutes in pan, then remove donuts from pan and transfer to a wire rack. Allow to cool completely before glazing.',
        'Make the chocolate glaze: Melt the chocolate, heavy cream, and butter gently in the microwave (in 30-second intervals, stirring in between) or a double boiler until smooth. Dip the tops of the donuts into the chocolate glaze, and place on a cooling rack to set.',
        'Donuts are best eaten the same day or keep them for up to 3 days in the refrigerator.',
      ],
      image: 'assets/desserts/03-chocolate-donuts.png',
      bgImageName: '',
      bgColor: AppColors.sugar,
    ),
    Recipe(
      id: 7,
      title: 'Strawberry Cake',
      description:
          'Jam-packed with fresh strawberries, this strawberry cake is one of the simplest, most delicious cakes you’ll ever make.',
      ingredients: [''],
      instructions: [''],
      image: 'assets/desserts/13-strawberry-powdered-cake.png',
      bgImageName: '',
      bgColor: AppColors.red,
    ),
    Recipe(
      id: 8,
      title: 'Fluffy Cake',
      description:
          "This is a very good everyday cake leavened with baking powder. It's relatively light—it isn't loaded with butter, and it calls for only 2 eggs and 2 percent milk. Mine was perfectly baked after 30 minutes. After 10 minutes on the cooling rack, the cake released from the pans easily.",
      ingredients: [
        '1/2 cup (1 stick) unsalted butter, cut into 2-tablespoon pieces and softened; plus more for coating pans',
        '2 1/4 cups all-purpose flour, plus more for coating pans',
        '1 1/3 cups granulated sugar',
        '1 tablespoon baking powder',
        '1/2 teaspoon salt',
        '1 tablespoon vanilla extract',
        '1 cup 2 percent milk, room temperature',
        '2 large eggs, room temperature',
      ],
      instructions: [
        'Gather the ingredients. Preheat the oven to 350 F.',
        'Butter and flour two 9-inch cake pans. If desired, line the bottom with a circle of parchment',
        'Combine the sugar, flour, baking powder, and salt in the bowl of a stand mixer fitted with the paddle attachment. Mix until the dry ingredients are combined.',
        'With the mixer on the lowest speed, add the butter one chunk at a time and blend until the mixture looks sandy, between 30 seconds and 1 minute. Scrape down the bowl and paddle with a rubber spatula.',
        'Add the vanilla extract and, with the mixer on low, pour in the milk. Stop and scrape, then mix for another minute.',
        'Add the first egg and mix on medium-low until completely incorporated. Add the second egg and do the same. Scrape down the bowl and mix until fluffy on medium speed, about 30 seconds.',
        'Pour the batter into the prepared pans and give each one a couple of solid taps on the countertop to release any air bubbles. Transfer the pans to the preheated oven.',
        'Bake for about 30 minutes, or until a toothpick inserted into the center comes out clean or with a crumb or two attached. The tops will be golden brown, the edges will pull away from the sides of the pan, and the cakes will spring back when you touch them.',
        'Cool the cakes in their pans on a wire rack for 10 minutes, then loosen the edges by running a knife along the sides of the pan. Turn the cakes out onto the racks and cool for at least 1 hour before frosting.',
        'Frost with your choice of frosting and enjoy.',
      ],
      image: 'assets/desserts/04-fluffy-cake.png',
      bgImageName: '',
      bgColor: AppColors.orangeDark,
    ),
    Recipe(
      id: 9,
      title: 'White Cream Cake',
      description:
          'This White Chocolate Cake is both decadent and delicious! White chocolate is incorporated into the cake layers, the frosting, and the drip for a stunning monochrome effect.',
      ingredients: [
        '2 ½ cups all-purpose flour',
        '1 teaspoon baking soda',
        '½ teaspoon baking powder',
        '½ teaspoon salt',
        '6 (1 ounce) squares white chocolate, chopped',
        '½ cup hot water',
        '1 cup butter, softened',
        '1 ½ cups white sugar',
        '3 eggs',
        '1 cup buttermilk',
        '6 (1 ounce) squares white chocolate, chopped',
        '2 ½ tablespoons all-purpose flour',
        '1 cup milk',
        '1 cup butter, softened',
        '1 cup white sugar',
        '1 teaspoon vanilla extract',
      ],
      instructions: [
        'Preheat oven to 350 degrees F (175 degrees C). Sift together the 2 1/2 cups flour, baking soda, baking powder and salt. Set aside.',
        'In small saucepan, melt 6 ounces white chocolate and hot water over low heat. Stir until smooth, and allow to cool to room temperature.',
        'In a large bowl, cream 1 cup butter and 1 1/2 cup sugar until light and fluffy. Add eggs one at a time, beating well with each addition. Stir in flour mixture alternately with buttermilk. Mix in melted white chocolate.',
        'Pour batter into two 9 inch round cake pans. Bake for 30 to 35 minutes in the preheated oven, until a toothpick inserted into the center of the cake comes out clean.',
        'To make Frosting: In a medium bowl, combine 6 ounces white chocolate, 2 1/2 tablespoons flour and 1 cup milk. Cook over medium heat, stirring constantly, until mixture is very thick. Cool completely.',
        'In large bowl, cream 1 cup butter, 1 cup sugar and 1 teaspoon vanilla; beat until light and fluffy. Gradually add cooled white chocolate mixture. Beat at high speed until it is the consistency of whipped cream. Spread between layers, on top and sides of cake.',
      ],
      image: 'assets/desserts/06-white-cream-cake.png',
      bgImageName: '',
      bgColor: AppColors.sugar,
    ),
    Recipe(
      id: 10,
      title: 'Fruit Pie',
      description:
          'Bake a hearty fruit pie for dessert. Our collection of year-round pastry classics includes apple & blackberry, summer berries, lemon meringue and mince pies.',
      ingredients: [''],
      instructions: [''],
      image: 'assets/desserts/14-fruit-pie.png',
      bgImageName: '',
      bgColor: AppColors.yellow,
    ),
    Recipe(
      id: 11,
      title: 'Honey Cake',
      description:
          "The secret to this cake's fantastic flavor is the tiny amount of bitterness from burnt honey. The slightly tangy whipped cream frosting provides a bit of acidity and lovely light texture, and unlike other frostings, it's not too sweet",
      ingredients: [
        '¾ cup wildflower honey',
        '3 tablespoons cold water',
        '1 cup white sugar',
        '14 tablespoons unsalted butter, cut into slices',
        '¾ cup wildflower honey',
        '2 ½ teaspoons baking soda',
        '1 teaspoon ground cinnamon',
        '¾ teaspoon fine salt',
        '6 large cold eggs',
        '3 ¾ cups all-purpose flour',
      ],
      instructions: [
        'Pour 3/4 cup wildflower honey into a deep saucepan over medium heat. Boil until a shade darker and caramel-like in aroma, about 10 minutes. Turn off heat and whisk in cold water.',
        'Preheat the oven to 375 degrees F (190 degrees C). Line a baking sheet with a silicone baking mat. Place a mixing bowl and whisk in the refrigerator.',
        'Place a large metal bowl over the lowest heat setting on the stovetop. Add sugar, butter, 3/4 cup wildflower honey, and 1/4 cup burnt honey. Let sit until butter melts, 5 to 7 minutes. Reserve remaining burnt honey for the frosting.',
        'Meanwhile, combine baking soda, cinnamon, and salt in a small bowl.',
        'Whisk butter mixture and let sit until very warm to the touch. Whisk in eggs. Keep mixture over low heat until it warms up again, then whisk in baking soda mixture. Remove from heat. Sift in flour in 2 or 3 additions, stirring well after each, until batter is easily spreadable.',
        'Transfer about 1/2 cup batter onto the prepared baking sheet. Spread into an 8- or 9-inch circle using an offset spatula. Shake and tap the pan to knock out any air bubbles.',
        'Bake in the preheated oven until lightly browned, 6 to 7 minutes. Remove liner from the pan and let cake layer continue cooling until firm enough to remove, 6 to 7 minutes. Invert cake onto a round of parchment paper.',
        'Repeat Steps 6 and 7 until you have 8 cake layers, letting each cool on an individual parchment round. Trim edges using a pizza wheel to ensure they are the same size; save scraps for crumb mixture.',
        'Spread any remaining batter onto the lined baking sheet. Bake in the preheated oven until edges are dry, about 10 minutes. Remove from the oven and cut into small pieces; toss with reserved cake scraps.',
        'Return scraps to the oven and bake until browned, 7 to 10 minutes more. Let cool completely, 15 to 20 minutes. Transfer to a resealable bag and beat into fairly fine crumbs using a rolling pin. Set aside.',
        'Remove the bowl and whisk from the refrigerator. Pour in heavy cream and whisk until soft peaks form. Add sour cream and remaining burnt honey; continue whisking until stiff peaks form.',
        'Place a cake layer on a parchment paper round on a pizza pan or serving plate. Spread a cup of frosting evenly on top, almost to the edge. Repeat with cake layers and frosting, pressing layers in smooth-side down. Place last cake layer smooth-side up. Frost top and sides of cake. Cover with crumbs; clean any excess crumbs around base.',
        'Cover with plastic wrap and refrigerate for at least 8 hours to overnight. Transfer to a cake stand using 2 spatulas. Cut and serve.',
      ],
      image: 'assets/desserts/07-honey-cake.png',
      bgImageName: '',
      bgColor: AppColors.honey,
    ),
    Recipe(
      id: 12,
      title: 'Powdered Cake',
      description:
          'Heavy on the butter and nutmeg, this cake has all the flavors of your favorite cake donut in a convenient square shape.',
      ingredients: [''],
      instructions: [''],
      image: 'assets/desserts/11-powdered-cake.png',
      bgImageName: '',
      bgColor: AppColors.sugar,
    ),
    Recipe(
      id: 13,
      title: 'Strawberries',
      description:
          "We'll admit it: we go a little crazy during strawberry season. Though easy to grow, these sweet berries just taste better when you get them in season, as opposed to buying them at other times of the year.",
      ingredients: [''],
      instructions: [''],
      image: 'assets/desserts/10-strawberries.png',
      bgImageName: '',
      bgColor: AppColors.red,
    ),
    Recipe(
      id: 14,
      title: 'Chocolate Cake',
      description:
          'The Best Chocolate Cake Recipe – A one bowl chocolate cake recipe that is quick, easy, and delicious! Updated with gluten-free, dairy-free, and egg-free options!',
      ingredients: [''],
      instructions: [''],
      image: 'assets/desserts/12-chocolate-cake-2.png',
      bgImageName: '',
      bgColor: AppColors.orangeDark,
    ),
    Recipe(
      id: 15,
      title: 'Apple Pie',
      description:
          "This was my grandmother's apple pie recipe. I have never seen another one quite like it. It will always be my favorite and has won me several first place prizes in local competitions.",
      ingredients: [''],
      instructions: [''],
      image: 'assets/desserts/15-apple-pie.png',
      bgImageName: '',
      bgColor: AppColors.sugar,
    ),
  ];
}

class AppColors {
  static const Color primary = Color(0xff7AC5C1);
  static const Color primaryLighter = Color(0xffE6F9FF);
  static const Color white = Color(0xffffffff);
  static const Color realBlack = Color(0xff000000);
  static const Color text = Color(0xff0F1E31);
  static const Color black = Color(0xff0F1E31);
  static const Color blackLight = Color(0xff1B2C41);
  static const Color orangeDark = Color(0xffCE5A01);
  static const Color yellow = Color(0xffFFEF7D);
  static const Color sugar = Color(0xffFBF5E9);
  static const Color honey = Color(0xffDA7C16);
  static const Color pinkLight = Color(0xffF9B7B6);
  static const Color green = Color(0xffADBE56);
  static const Color red = Color(0xffCF252F);
}
