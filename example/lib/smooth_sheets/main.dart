import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:moonspace/form/select.dart';

class SmoothSheetApp extends StatelessWidget {
  const SmoothSheetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomePage();
            },
            routes: [
              GoRoute(
                path: 'modalsheet',
                pageBuilder: (context, state) {
                  // Use ModalSheetPage to show a modal sheet with Navigator 2.0.
                  // It works with any *Sheet provided by this package!
                  return ModalSheetPage(
                    key: state.pageKey,
                    // Enable the swipe-to-dismiss behavior.
                    swipeDismissible: true,
                    // Use `SwipeDismissSensitivity` to tweak the sensitivity of the swipe-to-dismiss behavior.
                    swipeDismissSensitivity: const SwipeDismissSensitivity(
                      minFlingVelocityRatio: 2.0,
                      dismissalOffset: SheetOffset(0.4),
                    ),
                    // You don't need a SheetViewport for the modal sheet.
                    child: const _ModalSheet(),
                  );
                },
              ),

              ShellRoute(
                pageBuilder: (context, state, child) {
                  return CupertinoModalSheetPage(
                    key: state.pageKey,
                    child: PagedSheet(
                      decoration: MaterialSheetDecoration(
                        size: SheetSize.fit,
                        borderRadius: BorderRadius.circular(20),
                        clipBehavior: Clip.antiAlias,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      navigator: child,
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'cupertinomodal',
                    pageBuilder: (context, state) {
                      return PagedSheetPage(
                        key: state.pageKey,
                        child: Container(height: 300, color: Colors.white),
                      );
                    },
                  ),
                ],
              ),

              ShellRoute(
                builder: (context, state, child) {
                  return _ExampleHome(nestedNavigator: child);
                },
                routes: [
                  GoRoute(
                    path: 'a',
                    pageBuilder: (context, state) {
                      return PagedSheetPage(
                        key: state.pageKey,
                        snapGrid: const SheetSnapGrid(
                          snaps: [SheetOffset(0.8), SheetOffset(1)],
                        ),
                        child: const _ExampleSheetContent(
                          title: '/a',
                          heightFactor: 0.5,
                          destinations: ['/a/details', '/b'],
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'details',
                        pageBuilder: (context, state) {
                          return PagedSheetPage(
                            key: state.pageKey,
                            child: const _ExampleSheetContent(
                              title: '/a/details',
                              heightFactor: 0.75,
                              destinations: ['/a/details/info'],
                            ),
                          );
                        },
                        routes: [
                          GoRoute(
                            path: 'info',
                            pageBuilder: (context, state) {
                              return PagedSheetPage(
                                key: state.pageKey,
                                initialOffset: const SheetOffset(0.5),
                                snapGrid: const SheetSnapGrid(
                                  snaps: [
                                    SheetOffset(0.2),
                                    SheetOffset(0.5),
                                    SheetOffset(1),
                                  ],
                                ),
                                child: const _ExampleSheetContent(
                                  title: '/a/details/info',
                                  heightFactor: 1.0,
                                  destinations: ['/a', '/b', '/b/details'],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: '/b',
                    pageBuilder: (context, state) {
                      return PagedSheetPage(
                        key: state.pageKey,
                        child: const _ExampleSheetContent(
                          title: 'B',
                          heightFactor: 0.6,
                          destinations: ['/b/details', '/a'],
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'details',
                        pageBuilder: (context, state) {
                          return PagedSheetPage(
                            key: state.pageKey,
                            child: const _ExampleSheetContent(
                              title: 'B Details',
                              heightFactor: 0.5,
                              destinations: ['/a'],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showSheet(
  BuildContext context,
  SizedSheetDecoration sheetDecoration,
  SheetController controller,
  BottomBarVisibility bottomBarVisibility,
  SheetSnapGrid snapGrid,
  SheetPhysics sheetPhysics,
) {
  if (Random().nextBool()) {
    Navigator.push(
      context,
      ModalSheetRoute(
        viewportPadding: EdgeInsets.only(
          // Add the top padding to avoid the status bar.
          top: MediaQuery.viewPaddingOf(context).top,
        ),
        builder: (context) => Material(
          type: MaterialType.transparency,
          child: ExampleSheet(
            decoration: sheetDecoration,
            controller: controller,
            bottomBarVisibility: bottomBarVisibility,
            sheetPhysics: sheetPhysics,
            snapGrid: snapGrid,
          ),
        ),
      ),
    );
  } else {
    // Use `CupertinoModalSheetRoute` to show an ios style modal sheet.
    // For declarative navigation (Navigator 2.0), use `CupertinoModalSheetPage` instead.
    Navigator.push(
      context,
      CupertinoModalSheetRoute(
        // Enable the swipe-to-dismiss behavior.
        swipeDismissible: true,
        // Use `SwipeDismissSensitivity` to tweak the sensitivity of the swipe-to-dismiss behavior.
        swipeDismissSensitivity: const SwipeDismissSensitivity(
          minFlingVelocityRatio: 2.0,
          dismissalOffset: SheetOffset(0.4),
        ),
        builder: (context) => Material(
          type: MaterialType.transparency,
          child: ExampleSheet(
            decoration: sheetDecoration,
            controller: controller,
            bottomBarVisibility: bottomBarVisibility,
            sheetPhysics: sheetPhysics,
            snapGrid: snapGrid,
          ),
        ),
      ),
    );
  }
}

const _halfwayFraction = 0.6;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SheetSize _selectedSheetSize = SheetSize.fit;
  late SizedSheetDecoration _selectedSheetDecoration;
  late BottomBarVisibility _bottomBarVisibility;
  late SheetPhysics _sheetPhysics;
  late SheetSnapGrid _snapGrid;

  late final SheetController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SheetController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(GoRouter.of(context).state.fullPath ?? "*")),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () => context.go('/modalsheet'),
                    child: const Text('modal sheet'),
                  ),
                  TextButton(
                    onPressed: () => context.go('/cupertinomodal'),
                    child: const Text('cupertino modal'),
                  ),
                  TextButton(
                    onPressed: () => context.go('/a'),
                    child: const Text('a'),
                  ),

                  OptionBox<SheetSize>(
                    options: const [
                      Option(
                        value: SheetSize.stretch,
                        subtitle: Text(
                          "The sheet stretches to the bottom of the screen when it is over-dragged.",
                        ),
                      ),
                      Option(
                        value: SheetSize.fit,
                        selected: true,
                        subtitle: Text(
                          "The sheet size is always the same as the content.",
                        ),
                      ),
                    ],
                    init: (selected) => _selectedSheetSize = selected.first,
                    onChange: (selected) {
                      setState(() => _selectedSheetSize = selected.first);
                      showSheet(
                        context,
                        _selectedSheetDecoration,
                        _controller,
                        _bottomBarVisibility,
                        _snapGrid,
                        _sheetPhysics,
                      );
                    },
                  ),

                  const Divider(),

                  OptionBox<SheetPhysics>(
                    options: const [
                      Option(
                        compareBy: "ClampingSheetPhysics",
                        value: ClampingSheetPhysics(),
                      ),
                      Option(
                        compareBy: "BouncingSheetPhysics",
                        selected: true,
                        value: BouncingSheetPhysics(),
                      ),
                    ],
                    init: (selected) => _sheetPhysics = selected.first,
                    onChange: (selected) {
                      setState(() => _sheetPhysics = selected.first);
                      showSheet(
                        context,
                        _selectedSheetDecoration,
                        _controller,
                        _bottomBarVisibility,
                        _snapGrid,
                        _sheetPhysics,
                      );
                    },
                  ),

                  const Divider(),

                  OptionBox<SheetSnapGrid>(
                    options: const [
                      Option(
                        compareBy: "SteplessSnapGrid",
                        value: SteplessSnapGrid(
                          minOffset: SheetOffset(_halfwayFraction),
                        ),
                      ),
                      Option(
                        compareBy: "SingleSnapGrid",
                        selected: true,
                        value: SingleSnapGrid(snap: SheetOffset(1)),
                      ),
                      Option(
                        compareBy: "MultiSnapGrid",
                        value: MultiSnapGrid(
                          snaps: [
                            SheetOffset(_halfwayFraction),
                            SheetOffset(1),
                          ],
                        ),
                      ),
                    ],
                    init: (selected) => _snapGrid = selected.first,
                    onChange: (selected) {
                      setState(() => _snapGrid = selected.first);
                      showSheet(
                        context,
                        _selectedSheetDecoration,
                        _controller,
                        _bottomBarVisibility,
                        _snapGrid,
                        _sheetPhysics,
                      );
                    },
                  ),

                  const Divider(),

                  OptionBox<SizedSheetDecoration>(
                    options: [
                      Option(
                        selected: true,
                        compareBy: "MaterialSheetDecoration",
                        value: MaterialSheetDecoration(
                          size: _selectedSheetSize,
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16),
                          clipBehavior: Clip.antiAlias,
                        ),
                      ),
                      Option(
                        compareBy: "BoxSheetDecoration",
                        value: BoxSheetDecoration(
                          size: _selectedSheetSize,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.blue.shade100, Colors.blue],
                            ),
                          ),
                        ),
                      ),
                      Option(
                        compareBy: "SheetDecorationBuilder",
                        value: SheetDecorationBuilder(
                          size: _selectedSheetSize,
                          builder: (context, child) {
                            return ColoredBox(
                              color: Colors.blue,
                              // color: CupertinoColors.systemBackground,
                              child: FadeTransition(
                                opacity: SheetOffsetDrivenAnimation(
                                  controller: _controller,
                                  initialValue: 1,
                                  startOffset: const SheetOffset(0.95),
                                ),
                                child: child,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    init: (selected) =>
                        _selectedSheetDecoration = selected.first,
                    onChange: (selected) {
                      setState(() => _selectedSheetDecoration = selected.first);

                      showSheet(
                        context,
                        _selectedSheetDecoration,
                        _controller,
                        _bottomBarVisibility,
                        _snapGrid,
                        _sheetPhysics,
                      );
                    },
                  ),

                  const Divider(),

                  OptionBox<BottomBarVisibility>(
                    options: [
                      Option(
                        selected: true,
                        compareBy: "natural",
                        value: const BottomBarVisibility.natural(),
                      ),
                      Option(
                        compareBy: "always",
                        value: const BottomBarVisibility.always(),
                      ),
                      Option(
                        compareBy: "conditional",
                        value: BottomBarVisibility.conditional(
                          // This callback is called whenever the sheet metrics changes,
                          // and returning true keeps the bottom bar visible.
                          isVisible: (metrics) {
                            // The bottom bar is visible when at least 50% of the sheet is visible.
                            return metrics.offset >=
                                const SheetOffset(0.5).resolve(metrics);
                          },
                        ),
                      ),
                    ],
                    init: (selected) =>
                        _bottomBarVisibility = BottomBarVisibility.natural(),
                    onChange: (selected) {
                      _bottomBarVisibility = selected.first;

                      setState(() {});

                      showSheet(
                        context,
                        _selectedSheetDecoration,
                        _controller,
                        _bottomBarVisibility,
                        _snapGrid,
                        _sheetPhysics,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ExampleSheet extends StatelessWidget {
  const ExampleSheet({
    super.key,
    required this.decoration,
    required this.controller,
    required this.bottomBarVisibility,
    required this.snapGrid,
    required this.sheetPhysics,
  });

  final SizedSheetDecoration decoration;
  final BottomBarVisibility bottomBarVisibility;

  final SheetSnapGrid snapGrid;
  final SheetPhysics sheetPhysics;

  final SheetController controller;

  @override
  Widget build(BuildContext context) {
    return Sheet(
      scrollConfiguration: const SheetScrollConfiguration(),

      controller: controller,
      decoration: decoration,
      shrinkChildToAvoidStaticOverlap: true,

      initialOffset: const SheetOffset(0.5),

      physics: sheetPhysics,
      snapGrid: snapGrid,

      // snapGrid: const SheetSnapGrid(
      //   snaps: [SheetOffset(0.2), SheetOffset(0.5), SheetOffset(1)],
      // ),

      // snapGrid: SheetSnapGrid(
      //   snaps: [
      //     SheetOffset.absolute(56 + MediaQuery.of(context).padding.bottom),
      //     const SheetOffset(1),
      //   ],
      // ),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: SheetContentScaffold(
          bottomBarVisibility: bottomBarVisibility,
          extendBodyBehindBottomBar: true,
          bottomBar: _ExampleBottomBar(controller),
          topBar: AppBar(
            title: CupertinoButton.filled(
              onPressed: () {
                controller.animateTo(const SheetOffset(1));
              },
              child: const Text('Stack modal sheet'),
            ),
            actions: [
              CupertinoButton.filled(
                onPressed: () {
                  showSheet(
                    context,
                    decoration,
                    controller,
                    bottomBarVisibility,
                    snapGrid,
                    sheetPhysics,
                  );
                },
                child: const Text('Stack modal sheet'),
              ),
            ],
          ),
          body: Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: (_halfwayFraction * 10).toInt(),
                      child: Container(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        alignment: Alignment.center,
                        child: Text(
                          '${(_halfwayFraction * 100).toInt()}%',
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondaryContainer,
                              ),
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: (10 - _halfwayFraction * 10).toInt(),
                      child: Container(
                        color: Theme.of(context).colorScheme.tertiary,
                        alignment: Alignment.center,
                        child: Text(
                          '${(100 - _halfwayFraction * 100).toInt()}%',
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
                PageView(
                  children: const [
                    _PageViewItem(),
                    _PageViewItem(),
                    _PageViewItem(),
                  ],
                ),
                Align(child: _RotatedFlutterLogo(controller: controller)),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${SheetOffsetDrivenAnimation(controller: controller, initialValue: 1).value}',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PageViewItem extends StatefulWidget {
  const _PageViewItem();

  @override
  State<_PageViewItem> createState() => _PageViewItemState();
}

class _PageViewItemState extends State<_PageViewItem>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        return ListTile(onTap: () {}, title: Text('Item $index'));
      },
    );
  }
}

class _ExampleBottomBar extends StatelessWidget {
  const _ExampleBottomBar(this.controller);

  final SheetController controller;

  @override
  Widget build(BuildContext context) {
    // It is easy to create sheet offset driven animations
    // by using SheetOffsetDrivenAnimation, a special kind of
    // Animation<double> whose value changes from 0 to 1 as
    // the sheet offset changes from startOffset to endOffset.
    final animation = SheetOffsetDrivenAnimation(
      controller: controller,
      // The initial value of the animation is required
      // since the sheet does not have an offset at the first build.
      initialValue: 1,
      // If null, the minimum offset defined by Sheet.snapGrid will be used. (Default)
      startOffset: null,
      // If null, the maximum offset defined by Sheet.snapGrid will be used. (Default)
      endOffset: null,
    );

    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainer,
      // Use SafeArea to absorb the screen notch.
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        child: SizedBox.fromSize(
          size: const Size.fromHeight(kToolbarHeight),
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          ),
        ),
      ),
    );

    final bottomAppBar = BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
    );

    // Hide the bottom app bar when the sheet is dragged down.
    return SlideTransition(
      position: animation.drive(
        Tween(begin: const Offset(0, 1), end: Offset.zero),
      ),
      child: bottomAppBar,
    );
  }
}

class _RotatedFlutterLogo extends StatelessWidget {
  const _RotatedFlutterLogo({required this.controller});

  final SheetController controller;

  @override
  Widget build(BuildContext context) {
    final logo = RotationTransition(
      // Rotate the logo as the sheet offset changes.
      turns: SheetOffsetDrivenAnimation(
        controller: controller,
        initialValue: 1,
      ),
      child: const FlutterLogo(size: 100),
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Align(alignment: Alignment.topCenter, child: logo),
      ),
    );
  }
}

class _ExampleHome extends StatelessWidget {
  const _ExampleHome({required this.nestedNavigator});

  final Widget nestedNavigator;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Scaffold(),
        SheetViewport(child: _ExampleSheet(nestedNavigator: nestedNavigator)),
      ],
    );
  }
}

class _ExampleSheet extends StatelessWidget {
  const _ExampleSheet({required this.nestedNavigator});

  final Widget nestedNavigator;

  @override
  Widget build(BuildContext context) {
    return PagedSheet(
      decoration: MaterialSheetDecoration(
        size: SheetSize.stretch,
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
      ),
      navigator: nestedNavigator,
    );
  }
}

class _ExampleSheetContent extends StatelessWidget {
  const _ExampleSheetContent({
    required this.title,
    required this.heightFactor,
    required this.destinations,
  });

  final String title;
  final double heightFactor;
  final List<String> destinations;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSecondaryContainer;
    final textStyle = Theme.of(context).textTheme.displayMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: textColor,
    );

    // Tips: You can use SheetMediaQuery to get the layout information of the sheet
    // in the build method, such as the size of the viewport where the sheet is rendered.
    final sheetLayoutSpec = SheetMediaQuery.layoutSpecOf(context);

    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      width: double.infinity,
      height: sheetLayoutSpec.viewportSize.height * heightFactor,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(child: Text(title, style: textStyle)),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final dest in destinations)
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: textColor),
                    onPressed: () => context.go(dest),
                    child: Text('Go To $dest'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ModalSheet extends StatelessWidget {
  const _ModalSheet();

  @override
  Widget build(BuildContext context) {
    // You can use PopScope to handle the swipe-to-dismiss gestures, as well as
    // the system back gestures and tapping on the barrier, all in one place.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) {
          final shouldPop = await showConfirmationDialog(context);
          if (shouldPop == true && context.mounted) {
            context.go('/');
          }
        }
      },
      child: Sheet(
        decoration: MaterialSheetDecoration(
          size: SheetSize.stretch,
          color: Colors.red,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Container(
          height: 500,
          width: double.infinity,
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
      ),
    );
  }

  Future<bool?> showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
