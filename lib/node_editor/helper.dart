import 'dart:math' as math;

import 'package:flutter/material.dart';

Offset rotateAroundCenter(Offset point, Offset center, double angle) {
  final dx = point.dx - center.dx;
  final dy = point.dy - center.dy;

  final cosA = math.cos(angle);
  final sinA = math.sin(angle);

  final rotatedDx = dx * cosA - dy * sinA;
  final rotatedDy = dx * sinA + dy * cosA;

  return Offset(rotatedDx + center.dx, rotatedDy + center.dy);
}

const Offset offsetTopCenterRatio = Offset(0.5, 0);
const Offset offsetTopRightRatio = Offset(1, 0);
const Offset offsetBottomRightRatio = Offset(1, 1);
const Offset offsetBottomLeftRatio = Offset(0, 1);

const snapSize = 10.0;
const rotationSnapStep = math.pi / 12;
const degree90 = math.pi / 2;
