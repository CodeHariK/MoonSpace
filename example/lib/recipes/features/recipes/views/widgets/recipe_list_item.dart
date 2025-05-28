import 'package:flutter/material.dart';
import '../../../../core/enums/screen_size.dart';
import '../../../../core/styles/app_colors.dart';
import '../../models/recipe.dart';
import '../../recipes_layout.dart';
import '../pages/recipe_page.dart';
import 'recipe_image.dart';
import 'recipe_list_item_gesture_detector.dart';
import 'recipe_list_item_image_wrapper.dart';
import 'recipe_list_item_text.dart';

class RecipeListItem extends StatefulWidget {
  const RecipeListItem(
    this.recipe, {
    Key? key,
  }) : super(key: key);

  final Recipe recipe;

  @override
  State<RecipeListItem> createState() => _RecipeListItemState();
}

class _RecipeListItemState extends State<RecipeListItem> {
  double recipeImageRotationAngle = 0;

  @override
  Widget build(BuildContext context) {
    double imageSize = RecipesLayout.of(context).recipeImageSize;

    return RecipeListItemGestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder:
                (BuildContext context, Animation<double> animation, _) {
              return RecipePage(
                widget.recipe,
                initialImageRotationAngle: recipeImageRotationAngle,
              );
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation, _, Widget child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        )
            .then((response) {
          if (response != null && response is double && mounted) {
            setState(() {
              recipeImageRotationAngle = response;
            });
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.all(ScreenSize.of(context).isLarge ? 15 : 12.5),
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: '__recipe_${widget.recipe.id}_image_bg__',
                child: Container(
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    color: widget.recipe.bgColor,
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.orangeDark.withOpacity(
                          AppColors.getBrightness(widget.recipe.bgColor) ==
                                  Brightness.dark
                              ? 0.5
                              : 0.2,
                        ),
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  // child: RecipeListItemImage(recipe),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                alignment: Alignment.bottomRight,
                child: RecipeListItemImageWrapper(
                  child: RecipeImage(
                    widget.recipe,
                    imageRotationAngle: recipeImageRotationAngle,
                    imageSize: imageSize,
                    alignment: Alignment.bottomRight,
                    hasShadow: false,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: RecipeListItemText(widget.recipe),
                ),
                Expanded(flex: 2, child: Container()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
