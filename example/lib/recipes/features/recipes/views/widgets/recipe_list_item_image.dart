import 'package:flutter/material.dart';
import '../../models/recipe.dart';
import '../../recipes_layout.dart';
import 'recipe_list_item_image_wrapper.dart';

class RecipeListItemImage extends StatelessWidget {
  const RecipeListItemImage(
    this.recipe, {
    Key? key,
    this.imageRotationAngle = 0,
  }) : super(key: key);

  final Recipe recipe;
  final double imageRotationAngle;

  @override
  Widget build(BuildContext context) {
    double imageSize = RecipesLayout.of(context).recipeImageSize;

    return RecipeListItemImageWrapper(
      child: Hero(
        tag: '__recipe_${recipe.id}_image__',
        child: Transform.rotate(
          angle: imageRotationAngle,
          child: Image.asset(
            recipe.image,
            width: imageSize,
          ),
        ),
      ),
    );
  }
}
