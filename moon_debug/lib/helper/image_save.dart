import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:moonspace/helper/extensions/string.dart';

import 'package:path_provider/path_provider.dart';

class GridImage {
  final ui.Image image;
  final double width;
  final double height;

  GridImage(this.image)
    : width = image.width.toDouble(),
      height = image.height.toDouble();
}

Future<void> createGridImageFromFiles(
  List<File> imageFiles,
  int columns,
) async {
  const spacing = 16.0;

  // Load all images and get their sizes
  final images = <GridImage>[];
  for (final file in imageFiles) {
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    images.add(GridImage(frame.image));
  }

  // Calculate max width per column and row heights
  final columnWidths = List.filled(columns, 0.0);
  final rowHeights = <double>[];

  for (int i = 0; i < images.length; i++) {
    final col = i % columns;
    final row = i ~/ columns;

    if (rowHeights.length <= row) {
      rowHeights.add(0.0);
    }

    columnWidths[col] = math.max(columnWidths[col], images[i].width);
    rowHeights[row] = math.max(rowHeights[row], images[i].height);
  }

  final totalWidth =
      columnWidths.reduce((a, b) => a + b) + spacing * (columns + 1);
  final totalHeight =
      rowHeights.reduce((a, b) => a + b) + spacing * (rowHeights.length + 1);

  // Begin drawing
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint();

  double y = spacing;

  for (int row = 0; row < rowHeights.length; row++) {
    double x = spacing;

    for (int col = 0; col < columns; col++) {
      int i = row * columns + col;
      if (i >= images.length) break;

      final gridImage = images[i];
      canvas.drawImage(gridImage.image, Offset(x, y), paint);
      x += columnWidths[col] + spacing;
    }

    y += rowHeights[row] + spacing;
  }

  final picture = recorder.endRecording();
  final image = await picture.toImage(totalWidth.toInt(), totalHeight.toInt());

  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final pngBytes = byteData!.buffer.asUint8List();

  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/${randomString(4)}.png');
  await file.writeAsBytes(pngBytes);

  debugPrint('✅ Image saved: ${file.path}');
}

Future<void> createUniformHeightGrid({
  required List<File> imageFiles,
  int xCount = 3,
  double targetHeight = 200.0,
  double xPad = 16.0,
  double yPad = 16.0,
}) async {
  // Step 1: Load all images
  final loadedImages = <ui.Image>[];
  final widths = <double>[];

  for (final file in imageFiles) {
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final image = frame.image;

    final aspectRatio = image.width / image.height;
    final scaledWidth = targetHeight * aspectRatio;

    loadedImages.add(image);
    widths.add(scaledWidth);
  }

  // Step 2: Layout calculations
  final int totalImages = loadedImages.length;
  final int yCount = (totalImages / xCount).ceil();

  final rowWidths = List.generate(yCount, (_) => 0.0);

  int index = 0;
  for (int row = 0; row < yCount; row++) {
    for (int col = 0; col < xCount; col++) {
      if (index >= totalImages) break;
      rowWidths[row] += widths[index] + xPad;
      index++;
    }
    rowWidths[row] -= xPad; // Remove last xPad for trailing image
  }

  final canvasWidth = rowWidths.reduce((a, b) => a > b ? a : b);
  final canvasHeight = yCount * targetHeight + (yCount - 1) * yPad;

  // Step 3: Draw
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint();

  double y = 0;
  index = 0;

  for (int row = 0; row < yCount; row++) {
    double x = 0;
    for (int col = 0; col < xCount; col++) {
      if (index >= totalImages) break;
      final image = loadedImages[index];
      final width = widths[index];

      final srcRect = Rect.fromLTWH(
        0,
        0,
        image.width.toDouble(),
        image.height.toDouble(),
      );
      final dstRect = Rect.fromLTWH(x, y, width, targetHeight);

      canvas.drawImageRect(image, srcRect, dstRect, paint);

      x += width + xPad;
      index++;
    }
    y += targetHeight + yPad;
  }

  final picture = recorder.endRecording();
  final finalImage = await picture.toImage(
    canvasWidth.toInt(),
    canvasHeight.toInt(),
  );
  final byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);
  final pngBytes = byteData!.buffer.asUint8List();

  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/${randomString(4)}.png');
  await file.writeAsBytes(pngBytes);

  debugPrint('✅ Grid saved to ${file.path}');
  await Clipboard.setData(ClipboardData(text: file.path));
}

Future<void> capturePng(GlobalKey globalKey) async {
  try {
    // Find the RenderObject from the global key
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    // Capture the image
    ui.Image image = await boundary.toImage(pixelRatio: 4.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Save the file
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/${DateTime.now()}.png';
    final file = File(path);
    await file.writeAsBytes(pngBytes);

    debugPrint('Saved to $path');
    await Clipboard.setData(ClipboardData(text: path));
  } catch (e) {
    debugPrint('Error: $e');
  }
}
