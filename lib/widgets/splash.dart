import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SchedulerBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.light
          ? ThemeData.light()
          : ThemeData.dark(),
      home: Scaffold(
        body: Center(
          child: Animate(
            effects: const [
              FadeEffect(),
              ScaleEffect(),
            ],
            child: child,
          ),
        ),
      ),
    );
  }
}
