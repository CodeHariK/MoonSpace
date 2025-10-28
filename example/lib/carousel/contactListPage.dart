import 'dart:ui';
import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String role;
  final String address;
  final String phone;
  final String email;
  final String website;

  const Contact(
    this.name,
    this.role,
    this.address,
    this.phone,
    this.email,
    this.website,
  );

  static final contacts = List.generate(20, (i) {
    return Contact(
      'Mel',
      'Theya',
      'color',
      '010-1111-1111',
      'aaa@aaa.aa',
      'https://www.mel.com',
    );
  });
}

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.borderColor,
    required this.contact,
  });

  final Color borderColor;
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card tab
        Align(
          heightFactor: .9,
          alignment: Alignment.centerLeft,
          child: Container(
            height: 30,
            width: 70,
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        // Card Body
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Role
                  Row(
                    children: [
                      const Icon(Icons.person_outline, size: 40),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text.rich(
                          TextSpan(
                            text: '\n${contact.role}',
                            style: const TextStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PerspectiveListView extends StatefulWidget {
  const PerspectiveListView({
    super.key,
    required this.children,
    required this.itemExtent,
    required this.visualizedItems,
    this.initialIndex = 0,
    this.padding = const EdgeInsets.all(0),
    this.onTapFrontItem,
    this.onChangeItem,
    this.backItemsShadowColor = Colors.black,
  });

  final List<Widget> children;
  final double itemExtent;
  final int visualizedItems;
  final int initialIndex;
  final EdgeInsetsGeometry padding;
  final ValueChanged<int>? onTapFrontItem;
  final ValueChanged<int>? onChangeItem;
  final Color backItemsShadowColor;

  @override
  State<PerspectiveListView> createState() => _PerspectiveListViewState();
}

class _PerspectiveListViewState extends State<PerspectiveListView> {
  late PageController _pageController;
  late double _pagePercent;
  late int _currentIndex;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: widget.initialIndex,
      viewportFraction: 1 / widget.visualizedItems,
    );
    _currentIndex = widget.initialIndex;
    _pagePercent = 0.0;
    _pageController.addListener(_pageListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    _currentIndex = _pageController.page!.floor();
    _pagePercent = (_pageController.page! - _currentIndex).abs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final height = constrains.maxHeight;
        return Stack(
          children: [
            Padding(
              padding: widget.padding,
              child: _PerspectiveItems(
                heightItem: widget.itemExtent,
                currentIndex: _currentIndex,
                generateItems: widget.visualizedItems - 1,
                pagePercent: _pagePercent,
                children: widget.children,
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      widget.backItemsShadowColor.withAlpha(200),
                      widget.backItemsShadowColor.withAlpha(0),
                      widget.backItemsShadowColor.withAlpha(0),
                      widget.backItemsShadowColor.withAlpha(0),
                      widget.backItemsShadowColor.withAlpha(0),
                    ],
                  ),
                ),
              ),
            ),

            PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (value) {
                if (widget.onChangeItem != null) {
                  widget.onChangeItem!(value);
                }
              },
              itemBuilder: (context, index) {
                return const SizedBox();
              },
            ),

            Positioned.fill(
              top: height - widget.itemExtent,
              child: GestureDetector(
                onTap: () {
                  if (widget.onTapFrontItem != null) {
                    widget.onTapFrontItem!(_currentIndex);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PerspectiveItems extends StatelessWidget {
  const _PerspectiveItems({
    Key? key,
    required this.generateItems,
    required this.currentIndex,
    required this.heightItem,
    required this.pagePercent,
    required this.children,
  }) : super(key: key);

  final int generateItems;
  final int currentIndex;
  final double heightItem;
  final double pagePercent;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final height = constrains.maxHeight;
        return Stack(
          fit: StackFit.expand,
          children:
              List.generate(generateItems, (index) {
                  final invertedIndex = (generateItems - 2) - index;
                  final indexPlus = index + 1;
                  final positionPercent = indexPlus / generateItems;
                  final endPositionPercent = index / generateItems;
                  return (currentIndex > invertedIndex)
                      ? _TransformedItem(
                          heightItem: heightItem,
                          factorChange: pagePercent,
                          scale: lerpDouble(0.5, 1.0, positionPercent)!,
                          endScale: lerpDouble(0.5, 1.0, endPositionPercent)!,
                          translateY: (height - heightItem) * positionPercent,
                          endTranslateY:
                              (height - heightItem) * endPositionPercent,
                          child: children[currentIndex - (invertedIndex + 1)],
                        )
                      : const SizedBox();
                })
                ..add(
                  (currentIndex < children.length + 1)
                      ? _TransformedItem(
                          heightItem: heightItem,
                          factorChange: pagePercent,
                          translateY: height + 20,
                          endTranslateY: height - heightItem,
                          child: children[currentIndex + 1],
                        )
                      : const SizedBox(),
                )
                ..insert(
                  0,
                  currentIndex > generateItems - 1
                      ? _TransformedItem(
                          heightItem: heightItem,
                          factorChange: 1.0,
                          endScale: 0.5,
                          child: children[currentIndex - generateItems],
                        )
                      : const SizedBox(),
                ),
        );
      },
    );
  }
}

class _TransformedItem extends StatelessWidget {
  const _TransformedItem({
    Key? key,
    required this.child,
    required this.heightItem,
    required this.factorChange,
    this.scale = 1.0,
    this.endScale = 1.0,
    this.translateY = 0.0,
    this.endTranslateY = 0.0,
  }) : super(key: key);

  final Widget child;
  final double heightItem;
  final double factorChange;
  final double scale;
  final double endScale;
  final double translateY;
  final double endTranslateY;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.topCenter,
      transform: Matrix4.identity()
        ..scale(lerpDouble(scale, endScale, factorChange))
        ..translate(
          0.0,
          lerpDouble(translateY, endTranslateY, factorChange)!,
          0.0,
        ),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: heightItem,
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
