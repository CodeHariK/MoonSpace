import 'dart:ui';

import 'package:moonspace/painter/paint_helper.dart';

class ConvexHull {
  static List<Offset> wrap(List<Offset> points) {
    points.sort((a, b) => a.dx.compareTo(b.dx));

    final first = points.first;
    final last = points.last;

    List<Offset> up = [];
    List<Offset> down = [];

    for (int i = 0; i < points.length; i++) {
      final p = points[i];

      double isUp = crossProduct(p - first, last - first);
      if (isUp > 0) {
        up.add(p);
      } else if (isUp < 0) {
        down.add(p);
      } else {
        up.add(p);
        down.add(p);
      }
    }

    List<Offset> newUp = semiHull(up, true);

    List<Offset> newDown = semiHull(down, false);
    return {...newUp, ...newDown.reversed}.toList();
  }

  static List<Offset> semiHull(List<Offset> up, bool upward) {
    List<Offset> newUp = up.length > 2 ? up.sublist(0, 2) : up;

    for (int i = 2; i < up.length; i++) {
      final p0 = newUp[newUp.length - 2];
      final p1 = newUp[newUp.length - 1];
      final p2 = up[i];

      var pcrossProduct = crossProduct(p2 - p0, p1 - p0);
      if (upward ? pcrossProduct > 0 : pcrossProduct < 0) {
        newUp.removeLast();
      }

      newUp.add(p2);

      while (newUp.length > 2) {
        final n0 = newUp[newUp.length - 3];
        final n1 = newUp[newUp.length - 2];
        final n2 = newUp[newUp.length - 1];

        var ncrossProduct = crossProduct(n2 - n0, n1 - n0);
        if (upward ? ncrossProduct > 0 : ncrossProduct < 0) {
          newUp.removeAt(newUp.length - 2);
          continue;
        }
        break;
      }
    }
    return newUp;
  }
}
