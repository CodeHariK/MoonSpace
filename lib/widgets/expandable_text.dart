import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;
  final TextStyle? style;
  final TextStyle? readmoreStyle;

  const ExpandableText(
    this.text, {
    this.trimLines = 3,
    this.style,
    super.key,
    this.readmoreStyle = const TextStyle(color: Colors.blue),
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;
  bool _hasOverflow = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.style ?? DefaultTextStyle.of(context).style;

    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: widget.text, style: textStyle);
        final tp = TextPainter(
          text: span,
          textDirection: TextDirection.ltr,
          maxLines: widget.trimLines,
        )..layout(maxWidth: constraints.maxWidth);

        _hasOverflow = tp.didExceedMaxLines;

        final readMoreSpan = TextSpan(
          text: _expanded ? ' Show less' : ' Read more',
          style: widget.readmoreStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () => setState(() => _expanded = !_expanded),
        );

        return RichText(
          text: TextSpan(
            style: textStyle,
            children: <TextSpan>[
              TextSpan(
                text: _expanded
                    ? widget.text
                    : _hasOverflow
                    ? _trimText(widget.text, textStyle, constraints.maxWidth)
                    : widget.text,
              ),
              if (_hasOverflow) readMoreSpan,
            ],
          ),
        );
      },
    );
  }

  String _trimText(String text, TextStyle style, double maxWidth) {
    final span = TextSpan(style: style, text: '');
    final tp = TextPainter(text: span, textDirection: TextDirection.ltr);

    String trimmed = text;
    while (trimmed.isNotEmpty) {
      final attempt = '$trimmed... Read more';
      tp.text = TextSpan(text: attempt, style: style);
      tp.maxLines = widget.trimLines;
      tp.layout(maxWidth: maxWidth);
      final exceeded = tp.didExceedMaxLines;
      if (exceeded) {
        trimmed = trimmed.substring(0, trimmed.length - 1);
      } else {
        break;
      }
    }
    return '$trimmed...';
  }
}
