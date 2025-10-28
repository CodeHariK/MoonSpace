import 'package:flutter/widgets.dart';

class SyncScrollController extends TrackingScrollController {
  SyncScrollController({
    super.initialScrollOffset,
    super.keepScrollOffset,
    super.debugLabel,
  }) {
    addListener(_handleScroll);
  }

  void _handleScroll() {
    ScrollPosition? scrollPosition;

    // Identify the scroll position that is currently scrolling
    for (var sp in positions) {
      if (sp.isScrollingNotifier.value) {
        scrollPosition = sp;
        break;
      }
    }

    if (scrollPosition != null) {
      for (var sp in positions) {
        if (!identical(sp, scrollPosition)) {
          sp.jumpTo(scrollPosition.pixels);
        }
      }
    }
  }
}
