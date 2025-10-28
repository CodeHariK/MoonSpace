// Add support for testing drag gestures on desktop
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Create a subclass of ScrollBehavior that enables scrolling via mouse drag.
class AppScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices {
    final devices = Set<PointerDeviceKind>.from(super.dragDevices);
    devices.add(PointerDeviceKind.mouse);
    return devices;
  }
}
