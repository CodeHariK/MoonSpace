import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShimmmerCurve extends Curve {
  @override
  double transform(double t) {
    return clampDouble(t, 0, 1);
  }
}

class RainbowLogo extends StatelessWidget {
  const RainbowLogo({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [
        SlideEffect(
          begin: Offset(0, .07),
          end: Offset(0, 0),
          duration: Duration(milliseconds: 2000),
          curve: Curves.easeInOut,
        ),
      ],
      onComplete: (controller) {
        controller.repeat(reverse: true);
      },
      child: Animate(
        effects: [
          ShimmerEffect(
            // blendMode: BlendMode.dstATop,
            angle: math.pi / 4,
            size: 2,
            // colors: const [
            //   Color.fromARGB(80, 238, 255, 141),
            //   Color.fromARGB(160, 196, 141, 255),
            //   Color.fromARGB(160, 109, 201, 240),
            //   Color.fromARGB(160, 222, 231, 60),
            //   Color.fromARGB(160, 231, 60, 154),
            //   Color.fromARGB(160, 165, 213, 154),
            //   Color.fromARGB(160, 255, 169, 135),
            //   Color.fromARGB(80, 255, 135, 181),
            // ],
            colors: Colors.primaries.map((e) => e.withAlpha(150)).toList(),
            curve: ShimmmerCurve(),
            duration: const Duration(milliseconds: 5000),
          ),
        ],
        onComplete: (controller) {
          controller.repeat(reverse: true);
        },
        child: child,
      ),
    );
  }
}

class DottedBackgroundPainter extends CustomPainter {
  final Color color;
  DottedBackgroundPainter({super.repaint, required this.color});

  static const double gap = 18.0; // Gap between dots
  static const double radius = 1; // Radius of each dot

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    for (double j = 0; j < size.height; j += gap) {
      final off = (j % (2 * gap) == gap ? gap / 2 : 0);
      for (double i = 0; i < size.width; i += gap) {
        canvas.drawCircle(Offset(i + off, j), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class SunflowerPainter extends CustomPainter {
  static const tau = math.pi * 2;
  static final invGolden = 1 / ((math.sqrt(5) + 1) / 2);

  final int seeds;
  final double turns;
  final double scaleFactor;
  final double seedRadius;
  final Color color;

  SunflowerPainter({
    required this.seeds,
    required this.turns,
    this.scaleFactor = 4,
    this.seedRadius = 2.0,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerx = size.width / 2;
    final centery = size.height / 2;

    for (var i = 0; i < seeds; i++) {
      final theta = i * tau * turns;
      final r = math.sqrt(i) * scaleFactor;
      final x = centerx + r * math.cos(theta);
      final y = centery - r * math.sin(theta);
      final offset = Offset(x, y);
      if (!size.contains(offset)) {
        continue;
      }
      drawSeed(canvas, x, y);
    }
  }

  @override
  bool shouldRepaint(SunflowerPainter oldDelegate) {
    return oldDelegate.seeds != seeds;
  }

  void drawSeed(Canvas canvas, double x, double y) {
    final paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.fill
      ..color = color;
    canvas.drawCircle(Offset(x, y), seedRadius, paint);
  }
}

class Sunflower extends StatefulWidget {
  const Sunflower({
    super.key,
    required this.animCon,
    required this.color,
    required this.builder,
  });

  final AnimationController animCon;
  final Color color;
  final Widget? Function(AnimationController animCon) builder;

  @override
  State<StatefulWidget> createState() {
    return _SunflowerState();
  }
}

class _SunflowerState extends State<Sunflower> {
  double seeds = 400.0, turns = 0.6281;

  int get seedCount => seeds.floor();

  AnimationController get animCon => widget.animCon;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animCon,
      builder: (context, child) {
        return CustomPaint(
          painter: SunflowerPainter(
              seeds: (seedCount * animCon.value).toInt(),
              turns: turns,
              scaleFactor: 2.8 + 1.4 * animCon.value,
              color: widget.color),
          child: widget.builder(animCon),
        );
      },
    );
  }
}

class SolarPathPainter extends CustomPainter {
  final Size size;
  final Color color;
  SolarPathPainter(this.size, this.color) {
    createPath();
  }

  List<Offset> points = [];

  Offset movingPoint = const Offset(0, 0);
  double distance = 0;

  late Path path;

  void createPath() {
    path = Path()
      ..addArc(
        Rect.fromPoints(
          const Offset(0, 0),
          Offset(size.width, size.height),
        ),
        0,
        2 * math.pi,
      );

    for (double t = 0.0; t <= 1.0; t += 0.1) {
      Tangent? pos = path
          .computeMetrics()
          .single
          .getTangentForOffset(t * path.computeMetrics().single.length);
      if (pos?.position != null) {
        points.add(pos!.position);
      }
      movingPoint = points.first;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawPath(canvas);
    drawPoints(canvas);
    drawMovingPoint(canvas);
    updateMovingPoint();
  }

  void drawPath(Canvas canvas) {
    Paint pathPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawPath(path, pathPaint);
  }

  void drawPoints(Canvas canvas) {
    for (int i = 0; i < points.length; i++) {
      final point = points[i];
      canvas.drawCircle(point, 3.0, Paint()..color = Colors.primaries[i]);
    }
  }

  void drawMovingPoint(Canvas canvas) {
    Paint movingPointPaint = Paint()..color = Colors.blue;

    canvas.drawCircle(movingPoint, 5.0, movingPointPaint);
  }

  void updateMovingPoint() {
    distance += 0.002;
    distance = distance > .999 ? 0.002 : distance;

    Tangent? pos = path
        .computeMetrics()
        .single
        .getTangentForOffset(distance * path.computeMetrics().single.length);
    if (pos?.position != null) {
      movingPoint = pos!.position;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
