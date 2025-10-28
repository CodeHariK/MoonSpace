import 'dart:math' as math;
import 'dart:ui';

extension SuperListPoint on List<Offset> {
  List<Offset> rotateListOfOffsets(double angleInDegrees, Offset pivot) {
    final double angleInRadians = angleInDegrees * (math.pi / 180.0);
    final double cosA = math.cos(angleInRadians);
    final double sinA = math.sin(angleInRadians);

    return map((point) {
      final double dx = point.dx - pivot.dx;
      final double dy = point.dy - pivot.dy;

      final double rotatedDx = dx * cosA - dy * sinA;
      final double rotatedDy = dx * sinA + dy * cosA;

      return Offset(rotatedDx + pivot.dx, rotatedDy + pivot.dy);
    }).toList();
  }

  List<Offset> get mirrorY {
    return map((point) {
      return Offset(point.dx, -point.dy);
    }).toList();
  }

  List<Offset> get mirrorX {
    return map((point) {
      return Offset(-point.dx, point.dy);
    }).toList();
  }

  List<Offset> get flipXY {
    return map((point) {
      return Offset(point.dy, point.dx);
    }).toList();
  }

  List<Offset> offset(Offset offset) {
    return map((point) {
      return point + offset;
    }).toList();
  }

  List<Offset> scale(double scalex, double scaley) {
    return map((point) {
      return Offset(point.dx * scalex, point.dy * scaley);
    }).toList();
  }
}

List<Offset> merge(List<List<Offset>> path) {
  List<Offset> newPath = [];

  for (var path in path) {
    newPath.addAll(path.sublist(0, path.length - 1));
  }

  return newPath;
}

Path quadSmoothPath(List<Offset> points) {
  Path path = Path()..moveTo((points[0].dx + points[1].dx) / 2, (points[0].dy + points[1].dy) / 2);

  if (points.length > 2) {
    for (int i = 0; i < points.length; i += 1) {
      // Offset p0 = points[i];
      Offset p1 = points[(i + 1) % points.length];
      Offset p2 = points[(i + 2) % points.length];
      // Offset m1 = (p0 + p1) / 2;
      Offset m2 = (p1 + p2) / 2;

      path.quadraticBezierTo(p1.dx, p1.dy, m2.dx, m2.dy);
    }
  }
  return path;
}

double crossProduct(Offset v1, Offset v2) {
  return (v1.dx * v2.dy) - (v1.dy * v2.dx);
}

double dotProduct(Offset v1, Offset v2) {
  return (v1.dx * v2.dx) + (v1.dy * v2.dy);
}

Path dashPath(Path newPath) {
  Path dashPath = Path();

  double dashWidth = 10.0;
  double dashSpace = 5.0;
  double distance = 0.0;

  for (PathMetric pathMetric in newPath.computeMetrics()) {
    while (distance < pathMetric.length) {
      dashPath.addPath(
        pathMetric.extractPath(distance, distance + dashWidth),
        Offset.zero,
      );
      distance += dashWidth;
      distance += dashSpace;
    }
  }

  return dashPath;
}

extension CanvasExtension on Canvas {
  void drawCubicBezier(Offset p0, Offset p1, Offset p2, Offset p3, Paint paint) {
    final path = Path()
      ..moveTo(p0.dx, p0.dy)
      ..cubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);
    drawPath(path, paint);
  }
}
