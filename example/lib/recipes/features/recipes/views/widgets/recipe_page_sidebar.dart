import 'package:flutter/material.dart';
import '../../../../core/widgets/adaptive_offset_effect.dart';
import '../../../../core/widgets/app_bar_leading.dart';
import '../../../../core/widgets/fade_in_effect.dart';
import '../../models/recipe.dart';
import 'recipe_image.dart';
import 'recipe_image_pattern_mouse.dart';
import 'recipe_page_image_bg.dart';

class RecipePageSidebar extends StatelessWidget {
  const RecipePageSidebar(
    this.recipe, {
    Key? key,
    this.imageRotationAngle = 0,
  }) : super(key: key);

  final Recipe recipe;
  final double imageRotationAngle;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return AdaptiveOffsetEffect.builder(
      width: screenSize.width / 2,
      height: screenSize.height,
      child: RecipePageImageBg(
        recipe,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      childBuilder: (context, offset, child) => Stack(
        children: [
          child!,
          if (recipe.bgImageName.isNotEmpty)
            FadeInEffect(
              intervalStart: 0.5,
              child: RecipeImagePatternMouse(
                recipe,
                offset: offset,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
            ),
          IgnorePointer(
            ignoring: true,
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: RecipeImage(
                  recipe,
                  imageRotationAngle: imageRotationAngle,
                  shadowOffset: offset * 0.5,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: AppBarLeading(
              text: 'Back to Recipes',
              popValue: imageRotationAngle,
            ),
          ),
        ],
      ),
    );
  }
}
