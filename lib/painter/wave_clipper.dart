import 'package:flutter/material.dart';
import 'package:moonspace/painter/paint_helper.dart';

class WaveClipper extends CustomClipper<Path> {
  final int? numXDiv, numYDiv;
  final double? triXHeight, triYHeight, scaleLeft, scaleBottom, scaleRight, scaleTop;
  final bool smooth;

  const WaveClipper({
    this.numXDiv,
    this.numYDiv,
    this.triXHeight,
    this.triYHeight,
    this.scaleLeft,
    this.scaleBottom,
    this.scaleRight,
    this.scaleTop,
    this.smooth = true,
  });

  @override
  Path getClip(Size size) {
    final r = size.aspectRatio;
    final numXDiv = this.numXDiv ?? 10;
    final numYDiv = this.numYDiv ?? 10 ~/ r;
    final triXHeight = this.triXHeight ?? 4;
    final triYHeight = this.triYHeight ?? 4 / r;

    return wavePath(
      size: size,
      numXDiv: numXDiv + (numXDiv % 2 == 0 ? 1 : 0),
      numYDiv: numYDiv + (numYDiv % 2 == 0 ? 1 : 0),
      triXHeight: triXHeight,
      triYHeight: triYHeight,
      scaleLeft: scaleLeft ?? 1,
      scaleRight: scaleRight ?? 1,
      scaleTop: scaleTop ?? 1,
      scaleBottom: scaleBottom ?? 1,
      smooth: smooth,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}

Path wavePath({
  required Size size,
  required int numXDiv,
  required int numYDiv,
  required double triXHeight,
  required double triYHeight,
  required double scaleLeft,
  required double scaleRight,
  required double scaleTop,
  required double scaleBottom,
  required bool smooth,
}) {
  final width = (size.width - 2 * triYHeight);
  var height = (size.height - 2 * triXHeight);
  final double triXWidth = width / numXDiv;

  // Draw alternating triangles with equal height but opposite directions
  bool upward = true;

  final List<Offset> xPath = [const Offset(0, 0)];
  for (int i = 0; i < numXDiv; i++) {
    final double x = i * triXWidth;
    final double h = upward ? triXHeight : -triXHeight;
    xPath
      ..add(Offset(x + triXWidth / 2, -h))
      ..add(Offset(x + triXWidth, 0));

    upward = !upward;
  }

  final List<Offset> upPath = xPath.scale(1, scaleTop).offset(Offset(triYHeight, triXHeight));
  final List<Offset> downPath =
      xPath.scale(1, scaleBottom).mirrorY.offset(Offset(triYHeight, height + triXHeight)).reversed.toList();

  final double triYWidth = height / numYDiv;

  final List<Offset> yPath = [const Offset(0, 0)];
  for (int i = 0; i < numYDiv; i++) {
    final double y = i * triYWidth;
    final double h = upward ? -triYHeight : triYHeight;
    yPath
      ..add(Offset(-h, y + triYWidth / 2))
      ..add(Offset(0, y + triYWidth));

    upward = !upward;
  }

  final List<Offset> leftPath = yPath.scale(scaleLeft, 1).offset(Offset(triYHeight, triXHeight)).reversed.toList();
  final List<Offset> rightPath = yPath.scale(scaleRight, 1).mirrorX.offset(Offset(width + triYHeight, triXHeight));

  var path = merge([
    upPath,
    rightPath,
    downPath,
    leftPath,
  ]);

  if (smooth) {
    return quadSmoothPath(path);
  }
  return Path()..addPolygon(path, true);
}
