import 'dart:math';

import 'package:flutter/material.dart';

class GoogleLoader extends StatefulWidget {
  const GoogleLoader({super.key});

  @override
  State<GoogleLoader> createState() => _GoogleLoaderState();
}

class _GoogleLoaderState extends State<GoogleLoader>
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
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      valueColor: animationController.drive(
        ColorTween(
          begin: Colors.blueAccent,
          end: Colors.red,
        ),
      ),
    );
  }
}

class NeonButton extends StatefulWidget {
  final Color color;
  final Color textActiveColor;
  final String text;
  final Duration? duration;
  final VoidCallback? onTap;
  final bool animateAfterChanges;

  const NeonButton({
    super.key,
    required this.color,
    required this.text,
    this.duration,
    this.onTap,
    this.textActiveColor = Colors.black,
    this.animateAfterChanges = true,
  });

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  final ValueNotifier<bool> _notifierCompleted = ValueNotifier(false);

  @override
  void didUpdateWidget(NeonButton oldWidget) {
    if (widget.animateAfterChanges) {
      _notifierCompleted.value = false;
      _controller!.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ??
          const Duration(
            milliseconds: 12000,
          ),
    );
    _controller!.forward();
    _controller!.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _notifierCompleted.value = true;
        }
      },
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const padding = 20.0;
    return Padding(
      padding: const EdgeInsets.all(padding),
      child: CustomPaint(
        painter: _NeonLinePainter(
          animation: _controller,
          color: widget.color,
        ),
        child: ValueListenableBuilder<bool>(
          valueListenable: _notifierCompleted,
          builder: (context, completed, _) {
            return Material(
              color: completed ? widget.color : Colors.transparent,
              child: InkWell(
                onTap: () {
                  // _controller?.reset();
                  widget.onTap?.call();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    boxShadow: completed
                        ? [
                            BoxShadow(
                              blurRadius: padding,
                              spreadRadius: padding,
                              color: widget.color.withAlpha(200),
                            ),
                          ]
                        : null,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(padding),
                    child: FittedBox(
                      child: Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              completed ? widget.textActiveColor : widget.color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NeonLinePainter extends CustomPainter {
  final Animation? animation;
  final Color? color;

  _NeonLinePainter({
    this.animation,
    this.color,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final Paint paint = Paint()..color = Colors.transparent;
    final progress = animation!.value;
    if (progress > 0.0) {
      paint.color = Colors.black;
      paint.shader = SweepGradient(
        colors: const [
          Colors.red,
          Colors.blue,
          Colors.yellow,
          Colors.green,
          Colors.white,
          Colors.black,
        ],
        stops: const [
          0.0,
          0.2,
          0.4,
          0.6,
          0.8,
          1.0,
        ],
        startAngle: pi / 8,
        endAngle: pi / 2,
        transform: GradientRotation(pi * 2 * progress),
      ).createShader(rect);
    }
    final path = Path.combine(
      PathOperation.xor,
      Path()..addRect(rect),
      Path()..addRect(rect.deflate(4.0)),
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_NeonLinePainter oldDelegate) => true;
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
        vsync: this, duration: Duration(milliseconds: widget.lapDuration))
      ..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(
        begin: 0.0,
        end: 1.0,
      ).animate(controller),
      child: CustomPaint(
        painter: CirclePaint(
          // progress: animation.value,
          secondaryColor: widget.secondaryColor ??
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

    paint.shader = SweepGradient(
      colors: [secondaryColor, primaryColor],
      tileMode: TileMode.repeated,
      startAngle: _degreeToRad(270),
      endAngle: _degreeToRad(270 + 360.0),
    ).createShader(
        Rect.fromCircle(center: Offset(centerPoint, centerPoint), radius: 0));

    var scapSize = strokeWidth * 0.70;
    double scapToDegree = scapSize / centerPoint;
    double startAngle = _degreeToRad(270) + scapToDegree;
    double sweepAngle = _degreeToRad(360) - (2 * scapToDegree);

    canvas.drawArc(const Offset(0.0, 0.0) & Size(size.width, size.width),
        startAngle, sweepAngle, false, paint..color = primaryColor);
  }

  @override
  bool shouldRepaint(CirclePaint oldDelegate) {
    return true;
  }
}
