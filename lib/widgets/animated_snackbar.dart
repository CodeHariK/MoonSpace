import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moonspace/helper/extensions/theme_ext.dart';
import 'package:moonspace/widgets/animated_overlay.dart';

class AnimatedSnackbar extends StatelessWidget {
  const AnimatedSnackbar({
    super.key,
    this.hide = true,
    this.duration = const Duration(seconds: 3),
    required this.content,
    required this.title,
    this.icon,
    this.decoration,
    this.padding,
    this.margin,
    this.action = const [],
  });

  final bool hide;
  final Duration duration;
  final String content;
  final String title;
  final Icon? icon;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final List<Widget> action;

  AnimatedSnackbar copyWith({
    bool? hide,
    Duration? duration,
    String? content,
    String? title,
    Icon? icon,
    BoxDecoration? decoration,
    EdgeInsets? padding,
    EdgeInsets? margin,
    List<Widget>? action,
  }) {
    return AnimatedSnackbar(
      hide: hide ?? this.hide,
      duration: duration ?? this.duration,
      content: content ?? this.content,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      decoration: decoration ?? this.decoration,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      action: action ?? this.action,
    );
  }

  void show(
    BuildContext context, {
    Duration? duration,
    AlignmentGeometry alignment = Alignment.bottomCenter,
  }) {
    AnimatedOverlay.show(
      context: context,
      alignment: alignment,
      duration: duration ?? const Duration(seconds: 3),
      builder: (hide, scafSize, offset) {
        return copyWith(hide: hide);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: duration,
      tween: Tween(begin: hide ? 1.0 : 0.0, end: hide ? 0.0 : 1.0),
      curve: Curves.easeInOut,
      onEnd: () {
        if (hide) {
          AnimatedOverlay.hide();
        }
      },
      builder: (context, value, child) {
        final v = clampDouble(value * 4, 0, 1);
        return Transform.translate(
          offset: Offset(300 - v * 300, 0),
          child: Opacity(
            opacity: v,
            child: Container(
              decoration:
                  decoration ??
                  BoxDecoration(
                    color: context.cOnSur,
                    border: const Border(
                      left: BorderSide(width: 10, color: Colors.green),
                    ),
                    borderRadius: 16.br,
                  ),
              margin: margin ?? const EdgeInsets.all(8),
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: padding ?? const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child:
                              icon ??
                              Icon(Icons.star_border, color: context.cSur),
                        ),
                        // const SizedBox(height: 30, child: VerticalDivider()),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: context.tl.c(context.cSur)),
                              // const Divider(),
                              Text(content, style: context.ts.c(context.cSur)),
                            ],
                          ),
                        ),

                        //
                        ...action,
                        IconButton(
                          color: context.cSur,
                          onPressed: () {
                            AnimatedOverlay.hide();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  LinearProgressIndicator(value: value),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
