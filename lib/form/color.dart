import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moonspace/helper/extensions/color.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    this.onChange,
    this.initialColor,
    this.title,
    this.showHexCode = false,
  });

  final Widget? title;
  final bool showHexCode;
  final Color? initialColor;
  final void Function(Color color)? onChange;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  double hue = 0;
  double x = 1.0;
  double y = 0.5;
  Color selectedColor = Colors.transparent;

  @override
  void initState() {
    super.initState();

    final c = widget.initialColor;
    if (c != null) {
      final hsl = HSLColor.fromColor(c);

      final (xx, yy) = reverseBlend(hsl.saturation, hsl.lightness);

      hue = hsl.hue;
      x = xx;
      y = yy;
      updateColor(true);
    }
  }

  void updateColor(bool init) {
    final (blendedSaturation, blendedLightness) = blend(x, y);
    selectedColor = HSLColor.fromAHSL(
      1,
      hue,
      blendedSaturation,
      blendedLightness,
    ).toColor();
    if (!init) {
      widget.onChange?.call(selectedColor);
    }
  }

  void _handleHueUpdate(Offset localPosition, BoxConstraints constraints) {
    setState(() {
      hue = (localPosition.dx / constraints.maxWidth * 360).clamp(0, 360);
      updateColor(false);
    });
  }

  void _handleSLUpdate(Offset localPosition, BoxConstraints constraints) {
    setState(() {
      x = (localPosition.dx / constraints.maxWidth).clamp(0, 1.0);
      y = 1 - (localPosition.dy / constraints.maxHeight).clamp(0, 1.0);
      updateColor(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final (blendedSaturation, blendedLightness) = blend(x, y);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.title != null) widget.title!,
              if (widget.showHexCode) SelectableText(selectedColor.hexCode),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: selectedColor,
                ),
              ),
            ],
          ),

          // Saturation-Lightness Box
          SizedBox(
            height: 100,
            child: LayoutBuilder(
              builder: (context, constraints) => GestureDetector(
                onPanUpdate: (details) =>
                    _handleSLUpdate(details.localPosition, constraints),
                onPanDown: (details) =>
                    _handleSLUpdate(details.localPosition, constraints),
                child: CustomPaint(
                  size: Size(constraints.maxWidth, 200),
                  painter: _SLBoxPainter(hue: hue, nx: x, ny: y),
                ),
              ),
            ),
          ),

          // Hue Slider
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8),

            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: SizedBox(
                height: 10,
                child: LayoutBuilder(
                  builder: (context, constraints) => GestureDetector(
                    onPanUpdate: (details) =>
                        _handleHueUpdate(details.localPosition, constraints),
                    onPanDown: (details) =>
                        _handleHueUpdate(details.localPosition, constraints),
                    child: CustomPaint(
                      size: Size(constraints.maxWidth, 24),
                      painter: _HueSliderPainter(
                        hue,
                        blendedSaturation,
                        blendedLightness,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HueSliderPainter extends CustomPainter {
  final double hue;
  final double saturation;
  final double lightness;

  _HueSliderPainter(this.hue, this.saturation, this.lightness);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final gradient = LinearGradient(
      colors: List.generate(
        360,
        (h) => HSLColor.fromAHSL(1, h.toDouble(), 1, 0.5).toColor(),
      ),
    );

    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));

    final double x = (hue / 360 * size.width).clamp(0, size.width);
    drawSelectedColor(
      hue,
      saturation,
      lightness,
      canvas,
      x,
      size.height / 2,
      false,
    );
  }

  @override
  bool shouldRepaint(covariant _HueSliderPainter oldDelegate) =>
      oldDelegate.hue != hue;
}

class _SLBoxPainter extends CustomPainter {
  final double hue;
  final double nx;
  final double ny;

  _SLBoxPainter({required this.hue, required this.nx, required this.ny});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Draw saturation gradient (horizontal)
    final saturationGradient = LinearGradient(
      colors: [Colors.white, HSLColor.fromAHSL(1, hue, 1, 0.5).toColor()],
    );

    // Draw lightness gradient (vertical)
    final lightnessGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.white, Colors.black],
      stops: const [0.0, 1.0],
    );

    // Draw gradients with proper blending
    canvas.drawRect(
      rect,
      Paint()..shader = saturationGradient.createShader(rect),
    );
    canvas.drawRect(
      rect,
      Paint()
        ..shader = lightnessGradient.createShader(rect)
        ..blendMode = BlendMode.multiply,
    );

    final (blendedSaturation, blendedLightness) = blend(nx, ny);

    final x = nx * size.width;
    final y = (1 - ny) * size.height;

    drawSelectedColor(
      hue,
      blendedSaturation,
      blendedLightness,
      canvas,
      x,
      y,
      true,
    );
  }

  @override
  bool shouldRepaint(covariant _SLBoxPainter oldDelegate) =>
      oldDelegate.hue != hue || oldDelegate.nx != nx || oldDelegate.ny != ny;
}

// Define the four corner points with their (saturation, lightness) values
final bottomLeft = Point(0.0, 0.0); // (0,0)
final bottomRight = Point(1.0, 0.0); // (1,0)
final topLeft = Point(0.0, 1.0); // (0,1)
final topRight = Point(1.0, 0.5); // (1,0.5)

(double, double) blend(double nx, double ny) {
  // Calculate bilinear weights
  final wx = nx; // x interpolation factor
  final wy = ny; // y interpolation factor

  // First interpolate along top and bottom edges
  final top = Point(
    lerp(topLeft.x, topRight.x, wx),
    lerp(topLeft.y, topRight.y, wx),
  );

  final bottom = Point(
    lerp(bottomLeft.x, bottomRight.x, wx),
    lerp(bottomLeft.y, bottomRight.y, wx),
  );

  // Then interpolate between top and bottom results
  final result = Point(lerp(bottom.x, top.x, wy), lerp(bottom.y, top.y, wy));

  return (result.x, result.y);
}

(double, double) reverseBlend(double saturation, double lightness) {
  // Binary search to find nx (x coordinate)
  double low = 0.0;
  double high = 1.0;
  double nx = 0.5;

  for (int i = 0; i < 10; i++) {
    // 10 iterations for precision
    final top = Point(
      lerp(topLeft.x, topRight.x, nx),
      lerp(topLeft.y, topRight.y, nx),
    );
    final bottom = Point(
      lerp(bottomLeft.x, bottomRight.x, nx),
      lerp(bottomLeft.y, bottomRight.y, nx),
    );

    // Find ny that would give us the target lightness
    final ny = (lightness - bottom.y) / (top.y - bottom.y);
    final resultS = lerp(bottom.x, top.x, ny);

    if (resultS < saturation) {
      low = nx;
    } else {
      high = nx;
    }
    nx = (low + high) / 2;
  }

  // Calculate ny using the found nx
  final top = Point(
    lerp(topLeft.x, topRight.x, nx),
    lerp(topLeft.y, topRight.y, nx),
  );
  final bottom = Point(
    lerp(bottomLeft.x, bottomRight.x, nx),
    lerp(bottomLeft.y, bottomRight.y, nx),
  );

  final ny = (lightness - bottom.y) / (top.y - bottom.y);

  return (nx, ny);
}

// Helper function for linear interpolation
double lerp(double start, double end, double t) {
  return start + (end - start) * t;
}

void drawSelectedColor(
  double hue,
  double blendedSaturation,
  double blendedLightness,
  Canvas canvas,
  double x,
  double y,
  bool outline,
) {
  final color = HSLColor.fromAHSL(1, hue, blendedSaturation, blendedLightness);

  // Draw inner circle (fill)
  final fillPaint = Paint()
    ..color = color.toColor()
    ..style = PaintingStyle.fill;

  canvas.drawCircle(Offset(x, y), 8, fillPaint);

  final isDark = blendedLightness < 0.5;

  if (outline) {
    final outlinePaint = Paint()
      ..color = isDark ? Colors.white : Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(Offset(x, y), 8, outlinePaint);
  }
}
