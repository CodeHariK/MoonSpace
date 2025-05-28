import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppThemes {
  static ThemeData main({bool isDark = false}) {
    return ThemeData(
      primaryColor: AppColors.primary,
      primarySwatch: AppColors.primaryMaterialColor,
      brightness: isDark ? Brightness.dark : Brightness.light,
      fontFamily: AppTextStyles.fontFamily,
      scaffoldBackgroundColor: isDark ? AppColors.black : AppColors.sugar,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? AppColors.black : AppColors.sugar,
        elevation: 0,
      ),
      shadowColor: isDark
          ? AppColors.realBlack.withOpacity(0.4)
          : AppColors.black.withOpacity(0.2),
      cardColor: isDark ? AppColors.blackLight : AppColors.white,
    );
  }
}
