import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaskedRatingBar extends StatelessWidget {
  final double rating;
  final int starCount;
  final double starSize;
  final Color filledColor;
  final Color unfilledColor;

  const MaskedRatingBar({
    super.key,
    required this.rating,
    this.starCount = 5,
    this.starSize = 14,
    this.filledColor = const Color.fromARGB(255, 249, 207, 38),
    this.unfilledColor = const Color.fromARGB(255, 214, 214, 214),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            starCount,
            (_) => Icon(Icons.star, color: unfilledColor, size: starSize),
          ),
        ),

        ClipRect(
          clipper: _RatingClipper(rating / starCount),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              starCount,
              (_) => Icon(
                CupertinoIcons.star_fill,
                color: filledColor,
                size: starSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RatingClipper extends CustomClipper<Rect> {
  final double percent;

  _RatingClipper(this.percent);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width * percent, size.height);
  }

  @override
  bool shouldReclip(_RatingClipper oldClipper) {
    return oldClipper.percent != percent;
  }
}

class RatingsBars extends StatelessWidget {
  const RatingsBars({super.key, required this.percentages});

  final List<double> percentages;

  Widget _buildStarBar(int stars, double percent) {
    return Row(
      children: [
        Text('$stars'),
        const SizedBox(width: 6),
        Expanded(
          child: LinearProgressIndicator(
            value: percent,
            // backgroundColor: Colors.grey.shade300,
            // valueColor: AlwaysStoppedAnimation(Colors.amber),
            minHeight: 5,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: percentages
          .asMap()
          .entries
          .map((e) => _buildStarBar(percentages.length - e.key, e.value))
          .toList(),
    );
  }
}
