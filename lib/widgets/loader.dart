import 'dart:math';

import 'package:flutter/material.dart';

class GradientLoader extends StatefulWidget {
  const GradientLoader({super.key});

  @override
  State<GradientLoader> createState() => _GradientLoaderState();
}

class _GradientLoaderState extends State<GradientLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: animationController.drive(
        ColorTween(begin: Colors.blueAccent, end: Colors.red),
      ),
    );
  }
}

class CircularProgress extends StatefulWidget {
  const CircularProgress({
    super.key,
    required this.size,
    this.secondaryColor,
    this.primaryColor,
    this.lapDuration = 1000,
    this.strokeWidth = 5.0,
  });

  final double size;
  final Color? secondaryColor;
  final Color? primaryColor;
  final int lapDuration;
  final double strokeWidth;

  @override
  State<CircularProgress> createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.lapDuration),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: CustomPaint(
        painter: CirclePaint(
          // progress: animation.value,
          secondaryColor:
              widget.secondaryColor ??
              Theme.of(context).scaffoldBackgroundColor,
          primaryColor: widget.primaryColor ?? Theme.of(context).primaryColor,
          strokeWidth: widget.strokeWidth,
        ),
        size: Size(widget.size, widget.size),
      ),
    );
  }
}

class CirclePaint extends CustomPainter {
  final Color secondaryColor;
  final Color primaryColor;
  final double strokeWidth;

  // 2
  double _degreeToRad(double degree) => degree * pi / 180;

  CirclePaint({
    this.secondaryColor = Colors.grey,
    this.primaryColor = Colors.blue,
    this.strokeWidth = 15,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double centerPoint = size.height / 2;

    Paint paint = Paint()
      ..color = primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    paint.shader =
        SweepGradient(
          colors: [secondaryColor, primaryColor],
          tileMode: TileMode.repeated,
          startAngle: _degreeToRad(270),
          endAngle: _degreeToRad(270 + 360.0),
        ).createShader(
          Rect.fromCircle(center: Offset(centerPoint, centerPoint), radius: 0),
        );

    var scapSize = strokeWidth * 0.70;
    double scapToDegree = scapSize / centerPoint;
    double startAngle = _degreeToRad(270) + scapToDegree;
    double sweepAngle = _degreeToRad(360) - (2 * scapToDegree);

    canvas.drawArc(
      const Offset(0.0, 0.0) & Size(size.width, size.width),
      startAngle,
      sweepAngle,
      false,
      paint..color = primaryColor,
    );
  }

  @override
  bool shouldRepaint(CirclePaint oldDelegate) {
    return true;
  }
}
